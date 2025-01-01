return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    keys = {
      { '<leader>ee', ':NvimTreeToggle<CR>', desc = '[E]xplorer' },
      { '<leader>ef', ':NvimTreeFindFile<CR>', desc = '[E]xplorer [F]ind' },
      { '<leader>ec', ':NvimTreeCollapse<CR>', desc = '[E]exporer [C]ollapse' },
      { '<leader>er', ':NvimTreeRefresh<CR>', desc = '[E]xplorer [R]efresh' },
    },
    opts = {
      hijack_cursor = true,
      disable_netrw = true,
      renderer = {
        root_folder_label = false,
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
          quit_on_open = true,
        },
      },
    },
  },
}
