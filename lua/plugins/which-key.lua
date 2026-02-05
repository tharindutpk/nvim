vim.pack.add({
  { src = 'https://github.com/folke/which-key.nvim' },
})

require('which-key').setup({
  delay = 200,
  spec = {
    { '<leader>r', group = '[R]ename' },
    { '<leader>s', group = '[S]earch' },
    { '<leader>t', group = '[T]oggle' },
    { '<leader>h', group = 'Git [H]unk', mode = { 'n', 'v' } },
  },
})
