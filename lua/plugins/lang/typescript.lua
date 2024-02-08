return {
  {
    'nvim-treesitter/nvim-treesitter',
    opts = function(_, opts)
      if type(opts.ensure_installed) == 'table' then
        vim.list_extend(opts.ensure_installed, { 'css', 'html', 'javascript', 'typescript', 'svelte', 'tsx' })
      end
    end,
  },

  {
    'williamboman/mason.nvim',
    opts = function(_, opts)
      vim.list_extend(opts.ensure_installed, { 'prettierd' })
    end,
  },

  {
    'neovim/nvim-lspconfig',
    opts = {
      servers = {
        cssls = {},
        svelte = {},
        tailwindcss = {},
        tsserver = {},
      },
    },
  },

  {
    'nvimtools/none-ls.nvim',
    opts = function(_, opts)
      local null_ls = require('null-ls')
      opts.sources = vim.list_extend(opts.sources or {}, {
        null_ls.builtins.formatting.prettierd,
      })
    end,
  },
}
