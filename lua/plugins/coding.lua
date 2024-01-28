return {
  {
    'numToStr/Comment.nvim',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
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
    'rmagatti/alternate-toggler',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    keys = {
      { '<leader>tv', ':ToggleAlternate<CR>', desc = '[T]oggle [V]alue' },
    },
    opts = {},
  },
}
