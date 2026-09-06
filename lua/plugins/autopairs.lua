vim.pack.add({
  { src = "https://github.com/windwp/nvim-autopairs" },
})

-- Nothing to pair until insert mode is entered.
require("util.lazy").on("InsertEnter", function()
  require("nvim-autopairs").setup({})
end)
