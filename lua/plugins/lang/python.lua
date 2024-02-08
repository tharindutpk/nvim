return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'python' })
      end
    end,
  },

  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'black' })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        pyright = {
          python = {
            analysis = {
              autoSearchPaths = true,
              useLibraryCodeForTypes = true,
              diagnosticMode = 'openFilesOnly',
            },
          },
        },
        ruff_lsp = {},
      },
    },
  },

  {
    'nvimtools/none-ls.nvim',
    opts = function(_, opts)
      local null_ls = require('null-ls')
      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.black,
      })
    end,
  },
}
