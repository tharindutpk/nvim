return {
  {
    'nvimtools/none-ls.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = function(_, opts)
      local null_ls = require('null-ls')
      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.stylua,
      })
    end,
  },
}
