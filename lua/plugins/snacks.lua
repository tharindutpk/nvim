vim.pack.add({
  { src = "https://github.com/folke/snacks.nvim" },
})

-- Eager on purpose: bigfile and quickfile have to be in place before the first
-- buffer is read, and the dashboard has to exist before VimEnter.
require("snacks").setup({
  bigfile = { enabled = true }, -- disable heavy features on huge files
  quickfile = { enabled = true }, -- render the file before plugins finish loading
  dashboard = {
    sections = {
      { section = "header" },
      { icon = " ", title = "Keymaps", section = "keys", indent = 2, padding = 1 },
      { icon = " ", title = "Recent Files", section = "recent_files", indent = 2, padding = 1 },
      { icon = " ", title = "Projects", section = "projects", indent = 2, padding = 1 },
    },
  },
})
