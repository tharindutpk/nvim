vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim" },
})

--- Dashboard footer: how many plugins were up at startup, out of the total.
---
--- snacks ships a `startup` section for exactly this, but it reads
--- `lazy.stats`, and this config uses vim.pack. So: count it here instead.
---
--- "Total" is every plugin vim.pack has added to this session. "Loaded" is the
--- subset this config actually required while init.lua ran -- see
--- util.lazy.snapshot() for why that is measured there and not at render time.

--- Top-level module names a plugin provides, from its `lua/` directory.
--- nvim-tree.lua -> { "nvim-tree" }, blink.cmp -> { "blink" }.
---@param path string
---@return string[]
local function plugin_modules(path)
  local names = {}
  local dir = vim.uv.fs_scandir(path .. "/lua")

  if not dir then
    return names
  end

  for entry in
    function()
      return vim.uv.fs_scandir_next(dir)
    end
  do
    names[#names + 1] = (entry:gsub("%.lua$", ""))
  end

  return names
end

--- Captured on the first render, so reopening the dashboard later in the
--- session keeps reporting startup numbers rather than the session's age.
---@type { loaded: integer, total: integer, ms: number|nil }|nil
local stats

---@return { loaded: integer, total: integer, ms: number|nil }
local function startup_stats()
  if stats then
    return stats
  end

  local loaded_roots = require("util.lazy").startup_modules
  local loaded, total = 0, 0

  -- `vim.pack.get()` defaults to info=true, which runs git per plugin and
  -- costs ~100ms. The dashboard only needs names and paths, so ask for none.
  for _, plugin in ipairs(vim.pack.get(nil, { info = false })) do
    if plugin.active then
      total = total + 1

      for _, module in ipairs(plugin_modules(plugin.path)) do
        if loaded_roots[module] then
          loaded = loaded + 1
          break
        end
      end
    end
  end

  stats = {
    loaded = loaded,
    total = total,
    -- No stamp means init.lua lost its first line; show the counts anyway
    -- rather than erroring out and taking the whole dashboard with it.
    ms = vim.g.start_time and math.floor((vim.uv.hrtime() - vim.g.start_time) / 1e5 + 0.5) / 10 or nil,
  }

  return stats
end

---@type snacks.dashboard.Gen
local function startup_section()
  local current = startup_stats()

  local text = {
    { "⚡ ", hl = "footer" },
    { ("%d/%d"):format(current.loaded, current.total), hl = "special" },
    { " plugins loaded", hl = "footer" },
  }

  if current.ms then
    text[#text + 1] = { " in ", hl = "footer" }
    text[#text + 1] = { current.ms .. "ms", hl = "special" }
  end

  return { align = "center", text = text }
end

-- Eager on purpose: bigfile and quickfile have to be in place before the first
-- buffer is read, and the dashboard has to exist before VimEnter.
require("snacks").setup({
  bigfile = { enabled = true }, -- disable heavy features on huge files
  quickfile = { enabled = true }, -- render the file before plugins finish loading

  -- fzf-lua owns every picker in this config (lua/plugins/fzf.lua and the LSP
  -- mappings in lua/config/lsp.lua). Off by default, but stated explicitly so
  -- the dashboard keeps routing its Recent Files and Projects sections to
  -- fzf-lua, and so a future snacks release cannot flip the default.
  picker = { enabled = false },

  dashboard = {
    sections = {
      { section = "header" },
      { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
      { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
      { padding = 1 },
      startup_section,
    },
  },
})
