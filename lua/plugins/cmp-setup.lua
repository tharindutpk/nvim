local kind_icons = {
  Class = '',
  Color = '󰏘',
  Constant = '󰏿',
  Constructor = '',
  Enum = '',
  EnumMember = '',
  Event = '',
  Field = '󰜢',
  File = '󰈙',
  Folder = '󰉋',
  Function = '󰊕',
  Interface = '',
  Keyword = '󰌋',
  Method = '󰆧',
  Module = '󰆧',
  Operator = '󰆕',
  Property = '󰜢',
  Reference = '',
  Snippet = '',
  Struct = '󰙅',
  TypeParameter = '󰅲',
  Unit = '',
  Value = '󰎠',
  Variable = '󰀫',
  Text = '󰉿',
}

return {
  'hrsh7th/nvim-cmp',
  event = { 'InsertEnter' },
  dependencies = {
    -- Adds LSP completion capabilities
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-path',

    -- Snippet Engine & its associated nvim-cmp source
    'L3MON4D3/LuaSnip',
    'rafamadriz/friendly-snippets',
    'saadparwaiz1/cmp_luasnip',
    {
      'Saecki/crates.nvim',
      event = { 'BufRead Cargo.toml' },
      opts = {
        completion = {
          cmp = { enabled = true },
        },
      },
    },
  },
  opts = {},
  config = function()
    local cmp = require('cmp')
    local luasnip = require('luasnip')
    require('luasnip.loaders.from_vscode').lazy_load()
    luasnip.config.setup({})
    require('cmp').setup({
      snippet = {
        expand = function(args)
          luasnip.lsp_expand(args.body)
        end,
      },
      completion = {
        completeopt = 'menu,menuone,noinsert',
      },
      mapping = cmp.mapping.preset.insert({
        ['<C-d>'] = cmp.mapping.scroll_docs(-4),
        ['<C-f>'] = cmp.mapping.scroll_docs(4),
        ['<C-Space>'] = cmp.mapping.complete(),
        ['<CR>'] = cmp.mapping.confirm({
          behavior = cmp.ConfirmBehavior.Replace,
          select = true,
        }),
        ['<Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_next_item()
          elseif luasnip.expand_or_jumpable() then
            luasnip.expand_or_jump()
          else
            fallback()
          end
        end, { 'i', 's' }),
        ['<S-Tab>'] = cmp.mapping(function(fallback)
          if cmp.visible() then
            cmp.select_prev_item()
          elseif luasnip.jumpable(-1) then
            luasnip.jump(-1)
          else
            fallback()
          end
        end, { 'i', 's' }),
      }),
      sources = {
        { name = 'buffer' },
        { name = 'nvim_lsp' },
        { name = 'luasnip' },
        { name = 'path' },
      },
      formatting = {
        fields = { 'abbr', 'kind', 'menu' },
        expandable_indicator = true,
        format = function(entry, vim_item)
          -- Kind icons
          vim_item.kind = string.format('%s %s', kind_icons[vim_item.kind], vim_item.kind)
          -- Source
          vim_item.menu = ({
            buffer = '[Buffer]',
            nvim_lsp = '[LSP]',
            luasnip = '[LuaSnip]',
            nvim_lua = '[Lua]',
            latex_symbols = '[LaTeX]',
          })[entry.source.name]
          return vim_item
        end,
      },
    })
    vim.api.nvim_create_autocmd('BufRead', {
      group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
      pattern = 'Cargo.toml',
      callback = function()
        cmp.setup.buffer({ sources = { { name = 'crates' } } })
      end,
    })
  end,
}
