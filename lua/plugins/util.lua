return {
  { 'nvim-tree/nvim-web-devicons', lazy = true },

  { 'nvim-lua/plenary.nvim', lazy = true },

  { 'dstein64/vim-startuptime', cmd = 'StartupTime' },

  {
    'nvimdev/lspsaga.nvim',
    config = function()
      require('lspsaga').setup({})
    end,
    dependencies = {
      'nvim-treesitter/nvim-treesitter',
      'nvim-tree/nvim-web-devicons',
    },
  },
}
