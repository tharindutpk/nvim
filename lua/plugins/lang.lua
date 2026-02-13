vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/pmizio/typescript-tools.nvim" },
  { src = "https://github.com/mrcjkb/rustaceanvim" },
})

require("typescript-tools").setup({})
