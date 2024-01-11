return {
  'nvim-tree/nvim-tree.lua',
  cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>e',  ':NvimTreeToggle<CR>',   desc = '[E]xplorer' },
    { '<leader>er', ':NvimTreeFindFile<CR>', desc = '[E]xplorer [R]eveal' },
  },
  opts = {
    sort_by = 'case_sensitive',
    renderer = {
      group_empty = true,
      highlight_git = true,
    },
    filters = {
      dotfiles = true,
    },
  },
}
