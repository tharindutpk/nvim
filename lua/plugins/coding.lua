return {
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {},
  },

  {
    'folke/trouble.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {},
  },

  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = { 'nvim-lua/plenary.nvim' },
    opts = {},
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
      },
    },
  },

  {
    'kylechui/nvim-surround',
    version = '*', -- Use for stability; omit to use `main` branch for the latest features
    event = 'VeryLazy',
    config = function()
      require('nvim-surround').setup({
        -- Configuration here, or leave empty to use defaults
      })
    end,
  },

  {
    'rmagatti/alternate-toggler',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    keys = {
      { '<leader>tv', ':ToggleAlternate<CR>', desc = '[T]oggle [V]alue' },
    },
    opts = {},
  },
}
