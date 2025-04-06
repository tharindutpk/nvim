return {
  {
    'pmizio/typescript-tools.nvim',
    event = { 'BufReadPre', 'BufNewFile' },
    dependencies = {
      'nvim-lua/plenary.nvim',
      'neovim/nvim-lspconfig',
    },
    opts = {},
  },

  {
    'mrcjkb/rustaceanvim',
    lazy = false, -- This plugin is already lazy
  },
}
-- vim: ts=2 sts=2 sw=2 et
