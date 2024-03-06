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
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        ['handlebars'] = { 'prettierd' },
        ['html'] = { 'prettierd' },
        ['javascript'] = { 'prettierd' },
        ['javascriptreact'] = { 'prettierd' },
        ['json'] = { 'prettierd' },
        ['jsonc'] = { 'prettierd' },
        ['typescript'] = { 'prettierd' },
        ['typescriptreact'] = { 'prettierd' },
      },
    },
  },
}
