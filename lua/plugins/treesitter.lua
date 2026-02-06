vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-textobjects', version = 'main' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
}, { load = true })

local ensure_languages = {
  'bash',
  'lua',
  'rust',
  'go',
}

require('nvim-treesitter').install(ensure_languages)
require('nvim-treesitter').setup()
require('treesitter-context').setup({})
