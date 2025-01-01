return {
  {
    'utilyre/barbecue.nvim',
    name = 'barbecue',
    version = '*',
    dependencies = {
      'SmiteshP/nvim-navic',
      'nvim-tree/nvim-web-devicons',
    },
    opts = {
      show_dirname = false,
      show_basename = false,
      kinds = {
        Array = '',
        Boolean = '',
        Class = '',
        Constant = '󰏿',
        Constructor = '',
        Enum = '',
        EnumMember = '',
        Event = '',
        Field = '󰜢',
        File = '󰈙',
        Function = '󰊕',
        Interface = '',
        Key = '',
        Method = '',
        Module = '',
        Namespace = '',
        Null = '',
        Number = '',
        Object = '',
        Operator = '',
        Package = '',
        Property = '󰜢',
        String = '',
        Struct = '󰙅',
        TypeParameter = '',
        Variable = '󰀫',
      },
    },
  },
}
-- vim: ts=2 sts=2 sw=2 et
