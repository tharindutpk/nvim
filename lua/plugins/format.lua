return {
  -- {
  --   'stevearc/conform.nvim',
  --   event = { 'BufWritePre' },
  --   cmd = { 'ConformInfo' },
  --   opts = {
  --     formatters_by_ft = {
  --       lua = { 'stylua' },
  --     },
  --     format_on_save = { timeout_ms = 500, lsp_fallback = false },
  --   },
  -- },

  {
    'nvimtools/none-ls.nvim',
    opts = function(_, opts)
      local null_ls = require('null-ls')
      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.stylua,
      })
    end,
  },
}
