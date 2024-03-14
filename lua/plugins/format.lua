return {
  {
    'stevearc/conform.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    cmd = { 'ConformInfo' },
    opts = {
      formatters_by_ft = {
        lua = { 'stylua' },
      },
      format_on_save = { timeout_ms = 500, lsp_fallback = false },
    },
  },

  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      linters_by_ft = {
        lua = { 'luacheck' },
      },
    },
    config = function() end,
  },
}
