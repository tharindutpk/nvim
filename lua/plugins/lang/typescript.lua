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
    'stevearc/conform.nvim',
    opts = {
      formatters_by_ft = {
        ['css'] = { 'prettierd' },
        ['handlebars'] = { 'prettierd' },
        ['html'] = { 'prettierd' },
        ['javascript'] = { 'prettierd' },
        ['javascriptreact'] = { 'prettierd' },
        ['json'] = { 'prettierd' },
        ['jsonc'] = { 'prettierd' },
        ['svelte'] = { 'prettierd' },
        ['typescript'] = { 'prettierd' },
        ['typescriptreact'] = { 'prettierd' },
      },
    },
  },

  {
    'pmizio/typescript-tools.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {},
  },
}
