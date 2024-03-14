return {
  {
    'mfussenegger/nvim-lint',
    event = { 'BufReadPost', 'BufNewFile', 'BufWritePre' },
    opts = {
      linters_by_ft = {
        lua = { 'luacheck' },
      },
    },
    config = function() end,
  },
}
