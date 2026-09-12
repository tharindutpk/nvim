vim.pack.add({
  { src = "https://github.com/folke/which-key.nvim" },
})

-- Required last (see lua/plugins/init.lua) so every mapping already exists when
-- the groups below are registered.
require("util.lazy").later(function()
  require("which-key").setup({
    delay = 200,
    spec = {
      { "<leader>S", group = "Session" },
      { "<leader>b", group = "Buffer" },
      { "<leader>e", group = "Explorer" },
      { "<leader>f", group = "Format" },
      { "<leader>g", group = "Git", mode = { "n", "v" } },
      { "<leader>h", group = "Git hunk", mode = { "n", "v" } },
      { "<leader>p", group = "Packages" },
      { "<leader>r", group = "Run" },
      { "<leader>s", group = "Search" },
      { "<leader>t", group = "Toggle" },
    },
  })
end)
