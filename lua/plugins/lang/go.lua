return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'go', 'gomod' })
      end
    end,
  },

  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'goimports-reviser', 'gofumpt', 'golines' })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        gopls = {},
      },
    },
  },

  {
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        ['go'] = { 'goimports-reviser', 'golines', 'gofumpt' },
      },
    },
  },
}
