return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'go', 'gomod', 'gowork', 'gosum', 'templ' })
      end
    end,
  },

  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        ['go'] = { 'goimports', 'golines', 'gofumpt' },
      },
    },
  },

  {
    'joerdav/templ.vim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    config = function() end,
  },
}
