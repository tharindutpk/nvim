return {
  'akinsho/toggleterm.nvim',
  version = '*',
  event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
  opts = {
    open_mapping = [[<c-\>]],
    size = 12,
  },
}
