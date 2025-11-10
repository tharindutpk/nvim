return {
  {
    'rmagatti/alternate-toggler',
    event = { 'BufReadPost', 'BufNewFile' },
    keys = {
      { '<leader>tv', ':ToggleAlternate<CR>', desc = '[T]oggle [V]alue' },
    },
    opts = {},
  },

  -- {
  --   'folke/todo-comments.nvim',
  --   event = { 'BufReadPost', 'BufNewFile' },
  --   opts = {
  --     signs = false,
  --   },
  -- },

  {
    'folke/trouble.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    opts = {},
  },

  {
    'saghen/blink.indent',
    event = { 'BufReadPre', 'BufNewFile' },
    config = function()
      require('blink.indent').setup({
        static = {
          char = '│',
        },
        scope = {
          char = '│',
          highlights = { 'BlinkIndentScope' },
        },
      })
    end,
  },

  {
    'kylechui/nvim-surround',
    event = { 'BufReadPost', 'BufNewFile' },
    version = '*',
    opts = {},
  },
}
-- vim: ts=2 sts=2 sw=2 et
