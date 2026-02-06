vim.pack.add({ 'https://github.com/stevearc/conform.nvim' })

local conform = require('conform')

conform.setup({
  format_on_save = function(bufnr)
    -- Global or buffer-local disable
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end

    -- Disable LSP fallback for non-standardized styles
    local disable_filetypes = {
      lua = true,
    }

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
end, {
  desc = 'Format buffer or selection',
})

-- User commands: enable / disable autoformat
vim.api.nvim_create_user_command('FormatDisable', function(args)
  if args.bang then
    vim.b.disable_autoformat = true
  else
    vim.g.disable_autoformat = true
  end
end, {
  desc = 'Disable autoformat on save',
  bang = true,
})

vim.api.nvim_create_user_command('FormatEnable', function()
  vim.b.disable_autoformat = false
  vim.g.disable_autoformat = false
end, {
  desc = 'Enable autoformat on save',
})
