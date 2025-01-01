return {
  {
    'folke/tokyonight.nvim',
    priority = 1000,
    config = function()
      require('tokyonight').setup({
        styles = {
          comments = { italic = false },
          keywords = { italic = false },
        },
      })
      vim.cmd('colorscheme tokyonight-night')
    end,
  },
}
-- vim: ts=2 sts=2 sw=2 et
