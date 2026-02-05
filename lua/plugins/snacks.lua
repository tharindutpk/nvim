vim.pack.add({
  { src = 'https://github.com/folke/snacks.nvim' },
})

require('snacks').setup({
  bigfile = { enabled = true },
  dashboard = {
    sections = {
      { section = 'header' },
      { icon = ' ', title = 'Keymaps', section = 'keys', indent = 2, padding = 1 },
      { icon = ' ', title = 'Recent Files', section = 'recent_files', indent = 2, padding = 1 },
      { icon = ' ', title = 'Projects', section = 'projects', indent = 2, padding = 1 },
    },
  },
})
