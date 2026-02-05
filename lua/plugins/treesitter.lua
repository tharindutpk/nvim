vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
})

require('nvim-treesitter').setup({
  auto_install = true,
})
require('nvim-treesitter').install({
  'javascript',
  'lua',
  'go',
})
