return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'go', 'gomod', 'gowork', 'gosum' })
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
        gopls = {
          gopls = {
            hints = {
              assignVariableTypes = true,
              compositeLiteralFields = true,
              compositeLiteralTypes = true,
              constantValues = true,
              functionTypeParameters = true,
              parameterNames = true,
              rangeVariableTypes = true,
            },
            analyses = {
              fieldalignment = true,
              nilness = true,
              unusedparams = true,
              unusedvariable = true,
              unusedwrite = true,
              useany = true,
              shadow = true,
            },
            gofumpt = true,
            usePlaceholders = true,
            completeUnimported = true,
            staticcheck = true,
            semanticTokens = true,
          },
        },
      },
    },
  },

  {
    'nvimtools/none-ls.nvim',
    opts = function(_, opts)
      local null_ls = require('null-ls')
      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.goimports_reviser,
        null_ls.builtins.formatting.golines,
        null_ls.builtins.formatting.gofumpt,
      })
    end,
  },
}
