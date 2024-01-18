return {
  'glepnir/lspsaga.nvim',
  event = 'VeryLazy',
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
