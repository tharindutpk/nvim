return {
  {
    'catppuccin/nvim',
    name = 'catppuccin',
    lazy = false,
    config = function()
      require('catppuccin').setup({
        flavour = 'mocha', -- latte, frappe, macchiato, mocha
        color_overrides = {},
        custom_highlights = {},
        highlight_overrides = {
          mocha = function(mocha)
            return {
              -- Telescope highlights
              TelescopeBorder = { fg = mocha.green },
              TelescopeSelectionCaret = { fg = mocha.flamingo },
              TelescopeSelection = { fg = mocha.text, bg = mocha.surface2, style = { 'bold' } },
              TelescopeMatching = { fg = mocha.peach },
              TelescopePromptPrefix = { fg = mocha.text, bg = mocha.none },
              TelescopePromptNormal = { bg = mocha.crust },
              TelescopeResultsNormal = { bg = mocha.crust },
              TelescopePreviewNormal = { bg = mocha.crust },
              TelescopePromptBorder = { bg = mocha.crust, fg = mocha.mantle },
              TelescopeResultsBorder = { bg = mocha.crust, fg = mocha.mantle },
              TelescopePreviewBorder = { bg = mocha.crust, fg = mocha.mantle },
              TelescopePromptTitle = { fg = mocha.text, bg = mocha.none },
              TelescopeResultsTitle = { fg = mocha.text, bg = mocha.none },
              TelescopePreviewTitle = { fg = mocha.text, bg = mocha.none },
            }
          end,
        },
        integrations = {
          alpha = true,
          cmp = true,
          gitsigns = true,
          fidget = true,
          nvimtree = true,
          mason = true,
          lsp_saga = true,
          native_lsp = {
            enabled = true,
            underlines = {
              errors = { 'undercurl' },
              hints = { 'undercurl' },
              warnings = { 'undercurl' },
              information = { 'undercurl' },
            },
            inlay_hints = {
              background = false,
            },
          },
        },
        compile_path = vim.fn.stdpath('cache') .. '/catppuccin',
      })
      vim.cmd.colorscheme('catppuccin')
    end,
  },
}
