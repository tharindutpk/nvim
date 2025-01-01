return {
  {
    'rmagatti/alternate-toggler',
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      { '<leader>tv', ':ToggleAlternate<CR>', desc = '[T]oggle [V]alue' },
    },
    opts = {},
  },

  {
    'folke/todo-comments.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    opts = {
      signs = false,
    },
  },

  {
    'folke/trouble.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  {
    'lukas-reineke/indent-blankline.nvim',
    event = { 'BufReadPost', 'BufNewFile' },
    main = 'ibl',
    opts = {
      indent = {
        char = '│',
      },
      scope = {
        show_start = false,
        show_end = false,
      },
    },
  },

  {
    'kylechui/nvim-surround',
    event = { 'BufReadPost', 'BufNewFile' },
    version = '*',
    opts = {},
  },
}
-- vim: ts=2 sts=2 sw=2 et
