vim.pack.add({
  { src = 'https://github.com/folke/which-key.nvim' },
})

require('which-key').setup({
  delay = 200,
  spec = {
    { '<leader>r', group = 'Rename' },
    { '<leader>s', group = 'Search' },
    { '<leader>t', group = 'Toggle' },
    { '<leader>h', group = 'Git hunk', mode = { 'n', 'v' } },
  },
})
