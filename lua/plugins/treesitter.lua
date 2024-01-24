return {
  {
    'nvim-treesitter/nvim-treesitter',
    version = false,
    build = ':TSUpdate',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    dependencies = {
      'nvim-treesitter/nvim-treesitter-textobjects',
      {
        'nvim-treesitter/nvim-treesitter-context',
        enabled = true,
        opts = {
          mode = 'cursor',
          max_lines = 1,
        },
      },
      'windwp/nvim-ts-autotag',
    },
    opts = {
      ensure_installed = {
        'vimdoc',
        'bash',
        'lua',
        'markdown',
        'markdown_inline',
        'query',
        'regex',
        'vim',
        'yaml',
      },
      auto_install = true,
      highlight = { enable = true },
      indent = { enable = true },
      autotag = { enable = true },
    },
    config = function(_, opts)
      require('nvim-treesitter.configs').setup(opts)
    end,
  },
}
