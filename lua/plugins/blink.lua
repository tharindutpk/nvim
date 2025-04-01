return {
  {
    'saghen/blink.cmp',
    event = 'InsertEnter',
    version = '*',
    opts = {
      keymap = { preset = 'super-tab' },
      completion = {
        documentation = { auto_show = true, window = { border = 'none' } },
        menu = {
          draw = {
            padding = 0,
            columns = {
              { 'label', 'label_description', gap = 1 },
              { 'kind_icon', 'kind', gap = 1 },
            },
          },
        },
      },

      appearance = {
        use_nvim_cmp_as_default = true,
        nerd_font_variant = 'mono',
        kind_icons = {
          Class = '',
          Color = '󰏘',
          Constant = '󰏿',
          Constructor = '󰒓',
          Enum = '',
          EnumMember = '',
          Event = '󱐋',
          Field = '󰜢',
          File = '󰈙',
          Folder = '󰉋',
          Function = '󰊕',
          Interface = '',
          Keyword = '󰻾',
          Method = '󰆧',
          Module = '󰅩',
          Operator = '󰪚',
          Property = '󰖷',
          Reference = '󰬲',
          Snippet = '',
          Struct = '󰙅',
          Text = '󰉿',
          TypeParameter = '󰬛',
          Unit = '',
          Value = '󰎠',
          Variable = '󰀫',
        },
      },

      -- Default list of enabled providers defined so that you can extend it
      -- elsewhere in your config, without redefining it, due to `opts_extend`
      sources = {
        default = { 'lsp', 'path', 'snippets', 'buffer' },
      },
      signature = { enabled = true },
    },
    opts_extend = { 'sources.default' },
  },
}
-- vim: ts=2 sts=2 sw=2 et
