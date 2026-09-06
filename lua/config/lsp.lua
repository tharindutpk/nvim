-- LSP wiring. Server definitions live in lsp/<name>.lua and are picked up
-- automatically by `vim.lsp.enable()`. `:help lsp-config`
--
-- This file is required from init.lua *after* lua/plugins/, because enabling
-- the servers has to happen once blink.cmp has published its completion
-- capabilities.
local lazy = require("util.lazy")
local pick = require("plugins.fzf").pick

local servers = {
  "clangd",
  "gopls",
  "lua_ls",
  "ruff",
  "ty",
}

vim.diagnostic.config({
  severity_sort = true,
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = { source = true },
  jump = {
    -- Replaces the deprecated `jump = { float = true }`, which Nvim 0.14 drops.
    on_jump = function(_, bufnr)
      vim.diagnostic.open_float({ bufnr = bufnr, scope = "cursor", focus = false })
    end,
  },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("tharindutpk_lsp_attach", { clear = true }),
  desc = "Buffer-local LSP mappings and highlights",
  callback = function(event)
    ---@param keys string
    ---@param func function
    ---@param desc string
    ---@param mode? string|string[]
    local function map(keys, func, desc, mode)
      vim.keymap.set(mode or "n", keys, func, {
        buffer = event.buf,
        desc = "LSP: " .. desc,
      })
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client == nil then
      return
    end

    -- ruff and ty both attach to Python; ty owns hover and types, ruff owns
    -- lint and formatting.
    if client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end

    -- These override the built-in `gr*` defaults (`:help lsp-defaults`) with
    -- fzf-lua pickers. Wrapped in closures so fzf-lua is only loaded on the
    -- first press rather than whenever a server attaches.
    map("grd", pick("lsp_definitions"), "Goto definition")
    map("grt", pick("lsp_typedefs"), "Goto type definition")
    map("grr", pick("lsp_references"), "Goto references")
    map("gri", pick("lsp_implementations"), "Goto implementation")
    map("grD", vim.lsp.buf.declaration, "Goto declaration")
    map("gO", pick("lsp_document_symbols"), "Open document symbols")
    map("gW", pick("lsp_workspace_symbols"), "Open workspace symbols")
    map("grn", vim.lsp.buf.rename, "Rename")
    map("gra", vim.lsp.buf.code_action, "Code action", { "n", "x" })

    -- Highlight other references to the symbol under the cursor.
    if client:supports_method("textDocument/documentHighlight", event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup("tharindutpk_lsp_highlight", { clear = false })

      vim.api.nvim_create_autocmd({ "CursorHold", "CursorHoldI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.document_highlight,
      })

      vim.api.nvim_create_autocmd({ "CursorMoved", "CursorMovedI" }, {
        buffer = event.buf,
        group = highlight_augroup,
        callback = vim.lsp.buf.clear_references,
      })
    end

    if client:supports_method("textDocument/inlayHint", event.buf) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "Toggle inlay hints")
    end
  end,
})

vim.api.nvim_create_autocmd("LspDetach", {
  group = vim.api.nvim_create_augroup("tharindutpk_lsp_detach", { clear = true }),
  desc = "Drop reference highlights when a server detaches",
  callback = function(event)
    vim.lsp.buf.clear_references()
    -- The group only exists if some client asked for document highlighting.
    pcall(vim.api.nvim_clear_autocmds, {
      group = "tharindutpk_lsp_highlight",
      buffer = event.buf,
    })
  end,
})

-- Deferred so that blink.cmp -- which is itself deferred and publishes the
-- completion capabilities in lua/plugins/blink.lua -- has run first.
-- `vim.lsp.enable()` re-runs FileType for buffers that are already open, so
-- servers still attach to the file Nvim was started with.
lazy.later(function()
  vim.lsp.enable(servers)
end)
