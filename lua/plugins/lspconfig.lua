vim.pack.add({
  { src = 'https://github.com/mason-org/mason.nvim.git' },
  { src = 'https://github.com/mason-org/mason-lspconfig.nvim.git' },
  { src = 'https://github.com/neovim/nvim-lspconfig.git' },
  { src = 'https://github.com/j-hui/fidget.nvim' },
})

require('mason').setup()
require('mason-lspconfig').setup({
  ensure_installed = { 'lua_ls', 'gopls', 'basedpyright' },
})
require('fidget').setup()
