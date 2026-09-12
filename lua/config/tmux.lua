-- Run project commands in tmux from inside Neovim.
--
-- Two destinations, chosen by what the command is:
--
--   popup  -- `tmux display-popup -EE`. Floats over the editor, closes itself
--            when the command succeeds and stays put when it fails, so a
--            passing test is a flash and a failing one leaves its output on
--            screen. Used for tests, builds and linters.
--   run    -- the persistent `run`/`dev`/`repl` window that tmux-sessionizer
--            opens beside the editor. Used for servers and watchers, which
--            you want to keep glancing at.
--
-- No plugin: this shells out to tmux, and tmux does the work.

local M = {}

local POPUP_SIZE = { width = "80%", height = "80%" }

--- Root of the current project, by build-file marker.
---@return string
local function root()
  return vim.fs.root(0, {
    "Cargo.toml",
    "go.mod",
    "pyproject.toml",
    "package.json",
    ".git",
  }) or vim.uv.cwd()
end

--- Name of the enclosing definition, from treesitter.
---
--- The parse is forced: on a buffer opened a moment ago the tree may not exist
--- yet, and `get_node()` then quietly returns nil rather than erroring.
---@param types string[] Node types that count as a definition in this language.
---@return string|nil
local function name_from_treesitter(types)
  local ok, parser = pcall(vim.treesitter.get_parser, 0)

  if not ok or not parser then
    return nil
  end

  pcall(parser.parse, parser, true)

  local node = vim.treesitter.get_node()

  while node do
    if vim.tbl_contains(types, node:type()) then
      local name = node:field("name")[1]
      return name and vim.treesitter.get_node_text(name, 0) or nil
    end

    node = node:parent()
  end
end

--- Same thing by scanning upwards from the cursor. Used when the language has
--- no parser installed yet, so the mappings still work on a fresh machine.
---@param patterns string[] Lua patterns with one capture: the name.
---@return string|nil
local function name_from_patterns(patterns)
  local lines = vim.api.nvim_buf_get_lines(0, 0, vim.api.nvim_win_get_cursor(0)[1], false)

  for i = #lines, 1, -1 do
    for _, pattern in ipairs(patterns) do
      local match = lines[i]:match(pattern)

      if match then
        return match
      end
    end
  end
end

---@param types string[]
---@param patterns string[]
---@return string|nil
local function enclosing_name(types, patterns)
  return name_from_treesitter(types) or name_from_patterns(patterns)
end

--- Path of the current file relative to the project root.
---
--- Relative to the *root*, not to Nvim's cwd: the command runs with the root
--- as its working directory, and the two are often not the same.
---@return string
local function relative_file()
  local file = vim.api.nvim_buf_get_name(0)
  return vim.fs.relpath(root(), file) or vim.fn.fnamemodify(file, ":t")
end

--- Go wants a package path, not a file path.
---@return string
local function go_package()
  local dir = vim.fn.fnamemodify(relative_file(), ":h")
  return dir == "." and "." or "./" .. dir
end

--- Command builders per filetype. Each returns a command string, or nil when
--- that action does not apply to the language.
---@type table<string, table<string, fun(): string|nil>>
local runners = {
  go = {
    test_all = function()
      return "go test ./..."
    end,
    test_file = function()
      return "go test " .. go_package()
    end,
    test_nearest = function()
      local name = enclosing_name(
        { "function_declaration", "method_declaration" },
        { "^func%s+([%w_]+)%s*%(", "^func%s+%b()%s*([%w_]+)%s*%(" }
      )
      return name and ("go test -v -run '^%s$' %s"):format(name, go_package())
    end,
    check = function()
      return "go vet ./..."
    end,
    run = function()
      return "go run ."
    end,
  },

  rust = {
    test_all = function()
      return "cargo test"
    end,
    test_file = function()
      return "cargo test"
    end,
    test_nearest = function()
      local name = enclosing_name({ "function_item" }, { "^%s*fn%s+([%w_]+)" })
      return name and ("cargo test %s -- --nocapture"):format(name)
    end,
    check = function()
      return "cargo clippy --all-targets"
    end,
    run = function()
      return "cargo run"
    end,
  },

  python = {
    test_all = function()
      return "uv run pytest"
    end,
    test_file = function()
      return "uv run pytest " .. relative_file()
    end,
    test_nearest = function()
      local fn = enclosing_name({ "function_definition" }, { "^%s*def%s+([%w_]+)" })

      if not fn then
        return nil
      end

      local cls = enclosing_name({ "class_definition" }, { "^class%s+([%w_]+)" })
      local id = cls and ("%s::%s::%s"):format(relative_file(), cls, fn)
        or ("%s::%s"):format(relative_file(), fn)

      return "uv run pytest -v " .. id
    end,
    check = function()
      return "uv run ruff check ."
    end,
    run = function()
      return "uv run python " .. relative_file()
    end,
  },
}

-- The JS family all behave the same way.
for _, ft in ipairs({ "javascript", "javascriptreact", "typescript", "typescriptreact", "svelte" }) do
  runners[ft] = {
    test_all = function()
      return "pnpm test"
    end,
    test_file = function()
      return "pnpm test " .. relative_file()
    end,
    test_nearest = function()
      local name = enclosing_name(
        { "function_declaration", "arrow_function" },
        { "^%s*[%w_]*%s*[%(%'\"]([%w_ ]+)[%)%'\"]" }
      )
      return name and ("pnpm test -t '%s'"):format(name)
    end,
    check = function()
      return "pnpm exec biome check ."
    end,
    run = function()
      return "pnpm dev"
    end,
  }
end

-- ---------------------------------------------------------------- plumbing ---

---@param args string[]
---@return boolean ok, string stdout
local function tmux(args)
  local res = vim.system(vim.list_extend({ "tmux" }, args), { text = true }):wait()
  return res.code == 0, vim.trim(res.stdout or "")
end

---@return boolean
local function inside_tmux()
  return vim.env.TMUX ~= nil
end

--- Float the command over the editor. `-EE` means tmux closes the popup when
--- the command succeeds and leaves it open when it fails.
---@param cmd string
---@param cwd string
local function popup(cmd, cwd)
  vim.system({
    "tmux",
    "display-popup",
    "-d",
    cwd,
    "-w",
    POPUP_SIZE.width,
    "-h",
    POPUP_SIZE.height,
    "-EE",
    cmd,
  })
end

--- Send the command to the session's long-running window, creating it if the
--- session was not started by tmux-sessionizer.
---@param cmd string
---@param cwd string
local function send_run(cmd, cwd)
  local _, windows = tmux({ "list-windows", "-F", "#{window_name}" })

  local target
  for _, name in ipairs(vim.split(windows, "\n")) do
    if name == "run" or name == "dev" or name == "repl" then
      target = name
      break
    end
  end

  if not target then
    target = "run"
    tmux({ "new-window", "-d", "-n", target, "-c", cwd })
  end

  -- Interrupt whatever is already running there, then give the shell a moment
  -- to draw a fresh prompt before typing into it.
  tmux({ "send-keys", "-t", target, "C-c" })

  vim.defer_fn(function()
    tmux({ "send-keys", "-t", target, ("cd %s && %s"):format(vim.fn.shellescape(cwd), cmd), "Enter" })
  end, 120)
end

--- Without tmux the keymaps still do something useful.
---@param cmd string
---@param cwd string
local function fallback(cmd, cwd)
  vim.cmd("botright 15split")
  vim.fn.jobstart(cmd, { term = true, cwd = cwd })
  vim.cmd("wincmd p")
end

---@type { cmd: string, cwd: string, target: string }|nil
local last

---@param cmd string
---@param cwd string
---@param target "popup"|"run"
local function dispatch(cmd, cwd, target)
  last = { cmd = cmd, cwd = cwd, target = target }

  if not inside_tmux() then
    fallback(cmd, cwd)
    return
  end

  if target == "run" then
    send_run(cmd, cwd)
  else
    popup(cmd, cwd)
  end
end

-- ------------------------------------------------------------------ public ---

--- Run one of the actions defined in `runners` for the current filetype.
---@param action "test_all"|"test_file"|"test_nearest"|"check"|"run"
---@param target? "popup"|"run"
function M.run(action, target)
  local runner = runners[vim.bo.filetype]

  if not runner or not runner[action] then
    vim.notify(("No %s for filetype %q"):format(action, vim.bo.filetype), vim.log.levels.WARN)
    return
  end

  local cmd = runner[action]()

  if not cmd then
    vim.notify(("Could not work out what to %s here"):format(action), vim.log.levels.WARN)
    return
  end

  if vim.bo.modified then
    vim.cmd("write")
  end

  dispatch(cmd, root(), target or "popup")
end

--- Re-run whatever was run last, from any buffer.
function M.repeat_last()
  if not last then
    vim.notify("Nothing to repeat yet", vim.log.levels.WARN)
    return
  end

  dispatch(last.cmd, last.cwd, last.target)
end

local map = vim.keymap.set

map("n", "<leader>rt", function()
  M.run("test_nearest")
end, { desc = "Test nearest" })

map("n", "<leader>rf", function()
  M.run("test_file")
end, { desc = "Test file" })

map("n", "<leader>ra", function()
  M.run("test_all")
end, { desc = "Test all" })

map("n", "<leader>rc", function()
  M.run("check")
end, { desc = "Lint / check" })

map("n", "<leader>rr", function()
  M.run("run", "run")
end, { desc = "Run project (side window)" })

map("n", "<leader>rl", M.repeat_last, { desc = "Repeat last run" })

return M
