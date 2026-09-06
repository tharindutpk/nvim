--- Helpers for keeping work off the startup path.
---
--- This is deliberately *not* a plugin manager. `vim.pack.add()` still runs
--- eagerly for every plugin -- it only checks the plugin directory and extends
--- 'runtimepath', which is cheap. What these helpers defer is the expensive
--- part: the `require("plugin").setup({...})` call.
local M = {}

local group = vim.api.nvim_create_augroup("tharindutpk_lazy", { clear = true })

--- Run `fn` once, just after the first screen is drawn.
---
--- Use for anything the user cannot interact with in the first few
--- milliseconds: statusline, tabline, git signs, completion, formatters.
---@param fn fun()
function M.later(fn)
  -- Sourcing the config manually (`:source $MYVIMRC`) happens after VimEnter,
  -- in which case the autocmd would never fire.
  if vim.v.vim_did_enter == 1 then
    vim.schedule(fn)
    return
  end

  vim.api.nvim_create_autocmd("VimEnter", {
    group = group,
    once = true,
    callback = function()
      vim.schedule(fn)
    end,
  })
end

--- Run `fn` once, the first time any of `events` fires.
---@param events string|string[]
---@param fn fun()
---@param opts? table Extra fields for `nvim_create_autocmd` (e.g. `pattern`).
function M.on(events, fn, opts)
  vim.api.nvim_create_autocmd(
    events,
    vim.tbl_extend("force", {
      group = group,
      once = true,
      callback = function()
        fn()
      end,
    }, opts or {})
  )
end

--- Wrap `fn` so its body runs at most once, and return the wrapper.
---
--- Used to drive a plugin's `setup()` from a keymap: the plugin is configured
--- on the first press and the cached return value is reused after that.
---@generic T
---@param fn fun(): T
---@return fun(): T
function M.once(fn)
  local called, value = false, nil

  return function()
    if not called then
      called, value = true, fn()
    end
    return value
  end
end

return M
