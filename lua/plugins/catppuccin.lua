return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    priority = 1000,
    config = function()
      require('catppuccin').setup({
        favour = 'mocha',
        no_italic = true,
        integrations = {
          barbecue = {
            dim_dirname = true,
            bold_basename = true,
            dim_context = true,
            alt_background = true,
          },
          blink_cmp = true,
          fidget = true,
          fzf = true,
          mason = true,
          lsp_trouble = true,
        },
        compile_path = vim.fn.stdpath('cache') .. '/catppuccin',
      })
      vim.cmd('colorscheme catppuccin-mocha')
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
