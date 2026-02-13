vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-tree/nvim-tree.lua" },
})

require("nvim-tree").setup({
  hijack_cursor = true,
  disable_netrw = true,
  renderer = {
    -- root_folder_label = false,
    group_empty = true,
    special_files = { "Cargo.toml", "Makefile", "package.json", "package-lock.json", "README.md", "readme.md" },
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
    -- custom = { 'node_modules', '.git', '.idea' },
  },
  actions = {
    open_file = {
      quit_on_open = true,
    },
  },
})

vim.keymap.set("n", "<leader>ee", "<cmd>NvimTreeToggle<CR>", { desc = "Explorer" })
vim.keymap.set("n", "<leader>ef", "<cmd>NvimTreeFindFile<CR>", { desc = "Explorer find" })
vim.keymap.set("n", "<leader>ec", "<cmd>NvimTreeCollapse<CR>", { desc = "Eexporer collapse" })
vim.keymap.set("n", "<leader>er", "<cmd>NvimTreeRefresh<CR>", { desc = "Explorer refresh" })
