vim.pack.add({
  { src = "https://github.com/akinsho/toggleterm.nvim" },
})

require("util.lazy").later(function()
  require("toggleterm").setup({
    open_mapping = [[<c-\>]],
    size = 12,
  })
end)
