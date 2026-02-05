vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

local conform = require('conform')

conform.setup({
  format_on_save = function(bufnr)
    -- Disable with a global or buffer-local variable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    -- Disable "format_on_save lsp_fallback" for languages that don't
    -- have a well standardized coding style. You can add additional
    -- languages here or re-enable it for the disabled ones.
    local disable_filetypes = { c = true, cpp = true }
    local lsp_format_opt
    if disable_filetypes[vim.bo[bufnr].filetype] then
      lsp_format_opt = 'never'
    else
      lsp_format_opt = 'fallback'
    end
    return {
      lsp_format = lsp_format_opt,
      timeout_ms = 500,
    }
  end,
  formatters_by_ft = {
    css = { 'prettierd' },
    cpp = { 'clang_format' },
    go = { 'goimports', 'gofumpt' },
    html = { 'prettierd' },
    javascript = { 'prettierd' },
    javascriptreact = { 'prettierd' },
    json = { 'prettierd' },
    jsonc = { 'prettierd' },
    lua = { 'stylua' },
    markdown = { 'prettierd' },
    python = { 'ruff_format' },
    sh = { 'shfmt' },
    typescript = { 'prettierd' },
    typescriptreact = { 'prettierd' },
    yaml = { 'prettierd' },
  },
})

vim.keymap.set({ 'n', 'v' }, '<leader>fb', function()
  conform.format({
    async = true,
    lsp_format = 'fallback',
  })
end)
