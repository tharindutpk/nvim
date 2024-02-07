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
      special_files = { 'Cargo.toml', 'Makefile', 'package.json', 'package-lock.json', 'README.md', 'readme.md' },
      highlight_git = true,
      icons = {
        git_placement = 'after',
        diagnostics_placement = 'signcolumn',
      },
    },
    diagnostics = {
      enable = true,
      show_on_dirs = true,
    },
    filters = {
      git_ignored = false,
      custom = { 'node_modules', '.git', '.idea' },
    },
    actions = {
      open_file = {
        quit_on_open = false,
      },
    },
  },
}
