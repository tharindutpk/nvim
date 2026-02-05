vim.pack.add({
  { src = 'https://github.com/nvim-tree/nvim-web-devicons' },
  { src = 'https://github.com/catppuccin/nvim' },
  { src = 'https://github.com/akinsho/bufferline.nvim' },
})

require('bufferline').setup({
  options = {
    show_buffer_close_icons = false,
    offsets = {
      {
        filetype = 'NvimTree',
        highlight = 'Directory',
        separator = true,
        text = 'File Explorer',
      },
    },
  },
  highlights = require('catppuccin.special.bufferline').get_theme(),
})

vim.keymap.set('n', '<leader>bo', '<Cmd>BufferLineCloseOthers<CR>', { desc = 'Delete Other Buffers' })
vim.keymap.set('n', '<leader>br', '<Cmd>BufferLineCloseRight<CR>', { desc = 'Delete Buffers to the Right' })
vim.keymap.set('n', '<leader>bl', '<Cmd>BufferLineCloseLeft<CR>', { desc = 'Delete Buffers to the Left' })
vim.keymap.set('n', '<S-h>', '<Cmd>BufferLineCyclePrev<CR>', { desc = 'Prev Buffer' })
vim.keymap.set('n', '<S-l>', '<Cmd>BufferLineCycleNext<CR>', { desc = 'Next Buffer' })
