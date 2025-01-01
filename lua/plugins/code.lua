return {
  {
    'rmagatti/alternate-toggler',
    keys = {
      { '<leader>tv', ':ToggleAlternate<CR>', desc = '[T]oggle [V]alue' },
    },
    opts = {},
  },

  {
    'folke/todo-comments.nvim',
    opts = {
      signs = false,
    },
  },

  {
    'folke/trouble.nvim',
    opts = {},
  },

  {
    'lukas-reineke/indent-blankline.nvim',
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
    version = '*',
    opts = {},
  },
}
-- vim: ts=2 sts=2 sw=2 et
