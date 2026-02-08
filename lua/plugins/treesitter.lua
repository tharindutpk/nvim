vim.pack.add({
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter-context' },
  { src = 'https://github.com/windwp/nvim-ts-autotag' },
  { src = 'https://github.com/nvim-treesitter/nvim-treesitter', version = 'main' },
})

local ensure_languages = {
  'c',
  'cpp',
  'css',
  'diff',
  'go',
  'gomod',
  'gosum',
  'gowork',
  'html',
  'javascript',
  'lua',
  'luadoc',
  'markdown',
  'markdown_inline',
  'python',
  'query',
  'regex',
  'rust',
  'svelte',
  'templ',
  'toml',
  'tsx',
  'typescript',
  'vim',
  'vimdoc',
  'yaml',
}

require('nvim-treesitter').setup({
  auto_install = true,
  highlight = {
    enable = true,
    additional_vim_regex_highlighting = { 'ruby' },
  },
  indent = { enable = true, disable = { 'ruby' } },
})
require('nvim-treesitter').install(ensure_languages)

require('treesitter-context').setup({
  mode = 'topline',
  max_lines = 2,
})

vim.api.nvim_create_autocmd('FileType', {
  pattern = ensure_languages,
  callback = function()
    vim.treesitter.start()
  end,
})

require('nvim-ts-autotag').setup({})
