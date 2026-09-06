vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
})

-- Loaded on the first <leader>e mapping. netrw is left to oil.nvim, which is
-- the plugin that actually takes over directory buffers here.
local setup = require("util.lazy").once(function()
  require("nvim-tree").setup({
    hijack_cursor = true,
    disable_netrw = false,
    renderer = {
      group_empty = true,
      special_files = {
        "Cargo.toml",
        "Makefile",
        "README.md",
        "go.mod",
        "package.json",
        "pyproject.toml",
      },
      highlight_git = true,
      icons = {
        git_placement = "after",
        diagnostics_placement = "signcolumn",
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    filters = {
      git_ignored = false,
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
  })

  return require("nvim-tree.api")
end)

local map = vim.keymap.set

map("n", "<leader>ee", function()
  setup().tree.toggle()
end, { desc = "Explorer toggle" })

map("n", "<leader>ef", function()
  setup().tree.find_file({ open = true, focus = true })
end, { desc = "Explorer find file" })

map("n", "<leader>ec", function()
  setup().tree.collapse_all()
end, { desc = "Explorer collapse" })

map("n", "<leader>er", function()
  setup().tree.reload()
end, { desc = "Explorer refresh" })
