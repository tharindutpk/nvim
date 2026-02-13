vim.lsp.enable({
  "clangd",
  "gopls",
  "lua_ls",
  "ruff",
  "ty",
})

vim.diagnostic.config({
  severity_sort = true,
  underline = { severity = vim.diagnostic.severity.ERROR },
  virtual_text = {
    source = true,
  },
  jump = { float = true },
})

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("lsp-attach", { clear = true }),
  callback = function(event)
    local fzf = require("fzf-lua")

    local map = function(keys, func, desc, mode)
      mode = mode or "n"
      vim.keymap.set(mode, keys, func, {
        buffer = event.buf,
        desc = "LSP: " .. desc,
      })
    end

    local client = vim.lsp.get_client_by_id(event.data.client_id)

    if client == nil then
      return
    end

    if client.name == "ruff" then
      client.server_capabilities.hoverProvider = false
    end

    map("grt", fzf.lsp_definitions, "Goto type definition")
    map("grr", fzf.lsp_references, "Goto references")
    map("gri", fzf.lsp_implementations, "Goto implementation")
    map("grd", fzf.lsp_typedefs, "Goto definition")
    map("gO", fzf.lsp_document_symbols, "Open document symbols")
    map("gW", fzf.lsp_workspace_symbols, "Open workspace symbols")
    map("grn", vim.lsp.buf.rename, "Rename")
    map("gra", vim.lsp.buf.code_action, "Code action", { "n", "x" })
    map("grD", vim.lsp.buf.declaration, "Goto declaration")

    -- Document highlight for references of the word under your cursor
    if client and client:supports_method("textDocument/documentHighlight", event.buf) then
      local highlight_augroup = vim.api.nvim_create_augroup("lsp-highlight", { clear = false })

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

      vim.api.nvim_create_autocmd("LspDetach", {
        group = vim.api.nvim_create_augroup("lsp-detach", { clear = true }),
        callback = function(event2)
          vim.lsp.buf.clear_references()
          vim.api.nvim_clear_autocmds({
            group = "lsp-highlight",
            buffer = event2.buf,
          })
        end,
      })
    end

    -- The following code creates a keymap to toggle inlay hints in your code
    if client and client:supports_method("textDocument/inlayHint", event.buf) then
      map("<leader>th", function()
        vim.lsp.inlay_hint.enable(not vim.lsp.inlay_hint.is_enabled({ bufnr = event.buf }))
      end, "Toggle inlay hints")
    end
  end,
})
