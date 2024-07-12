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
        go = { 'goimports', 'golines', 'gofumpt' },
        lua = { 'stylua' },
        sh = { 'shfmt' },
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
