return {
  {
    'hrsh7th/nvim-cmp',
    dependencies = {
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
    opts = function()
      local cmp = require('cmp')
      vim.api.nvim_create_autocmd('BufRead', {
        group = vim.api.nvim_create_augroup('CmpSourceCargo', { clear = true }),
        pattern = 'Cargo.toml',
        callback = function()
          cmp.setup.buffer({ sources = { { name = 'crates' } } })
        end,
      })
    end,
  },
}
