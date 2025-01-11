return {
  {
    'nvim-lualine/lualine.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'catppuccin',
        component_separators = { left = '', right = '' },
        section_separators = { left = '', right = '' },
        disabled_filetypes = { 'alpha', 'NVimTree' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { { 'branch' } },
        lualine_c = { { 'filename', file_status = true, path = 1 } },
        lualine_x = { 'diff', 'diagnostics', 'encoding', 'fileformat', 'filetype' },
      },
      extensions = { 'lazy', 'mason', 'nvim-tree', 'toggleterm' },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
