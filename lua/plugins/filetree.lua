return {
  'nvim-tree/nvim-tree.lua',
  cmd = { 'NvimTreeToggle', 'NvimTreeFocus' },
  version = '*',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons',
  },
  keys = {
    { '<leader>e', ':NvimTreeToggle<CR>', desc = '[E]xplorer' },
    { '<leader>er', ':NvimTreeFindFile<CR>', desc = '[E]xplorer [R]eveal' },
  },
  opts = {
    hijack_cursor = true,
    disable_netrw = true,
    renderer = {
      group_empty = true,
      highlight_git = true,
      icons = {
        git_placement = 'after',
        modified_placement = 'after',
      },
    },
    actions = {
      open_file = {
        quit_on_open = true,
      },
    },
  },
}
