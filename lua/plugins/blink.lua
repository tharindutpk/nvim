vim.pack.add({
  { src = 'https://github.com/saghen/blink.cmp', version = 'v1.9.1' },
})

require('blink-cmp').setup({
  keymap = {
    preset = 'enter',
    ['<Tab>'] = { 'select_next', 'fallback' },
    ['<S-Tab>'] = { 'select_prev', 'fallback' },
  },
  completion = {
    documentation = { auto_show = true },
  },
  appearance = {
    nerd_font_variant = 'mono',
  },
  sources = {
    default = { 'lsp', 'path', 'snippets', 'buffer' },
  },
  signature = { enabled = true },
  fuzzy = { implementation = 'prefer_rust_with_warning' },
})
