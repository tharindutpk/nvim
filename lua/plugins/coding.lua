return {
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
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    version = '*',
    opts = {},
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
