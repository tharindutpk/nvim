return {
  'nvim-lualine/lualine.nvim',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
  dependencies = { 'nvim-tree/nvim-web-devicons' },
  opts = {
    options = {
      theme = 'tokyonight',
      component_separators = ' ',
      section_separators = '',
      disabled_filetypes = { 'alpha' },
    },
  },
}
