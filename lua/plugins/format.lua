return {
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    cmd = { 'ConformInfo' },
    keys = {
      {
        '<leader>fb',
        function()
          require('conform').format({ async = true, lsp_format = 'fallback' })
        end,
        mode = '',
        desc = '[F]ormat [B]uffer',
      },
    },
    opts = {
      formatters_by_ft = {
        css = { 'prettierd' },
        go = { 'goimports', 'golines', 'gofumpt' },
        handlebars = { 'prettierd' },
        html = { 'prettierd' },
        javascript = { 'prettierd' },
        javascriptreact = { 'prettierd' },
        json = { 'prettierd' },
        jsonc = { 'prettierd' },
        lua = { 'stylua' },
        sh = { 'shfmt' },
        svelte = { 'prettierd' },
        typescript = { 'prettierd' },
        typescriptreact = { 'prettierd' },
      },
      format_on_save = function(bufnr)
        -- Disable with a global or buffer-local variable
        if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
          return
        end
        return { timeout_ms = 500, lsp_format = 'fallback' }
      end,
    },
  },
}
