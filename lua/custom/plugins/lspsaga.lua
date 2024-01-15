return {
  'glepnir/lspsaga.nvim',
  lazy = true,
  dependencies = {
    { 'nvim-tree/nvim-web-devicons' },
    { 'nvim-treesitter/nvim-treesitter' },
  },
  opts = {
    lightbulb = {
      enable = false,
    },
  },
}
