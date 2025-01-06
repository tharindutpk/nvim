return {
  {
    'akinsho/toggleterm.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    version = '*',
    opts = {
      open_mapping = [[<c-\>]],
      size = 12,
    },
  },
}
