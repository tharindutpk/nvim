return {
  'folke/which-key.nvim',
  event = 'VeryLazy',
  keys = {
    {
      '<leader>?',
      function()
        require('which-key').show({ global = false })
      end,
      desc = 'Buffer Local Keymaps (which-key)',
    },
  },
  opts = {
    -- preset = 'classic',
    expand = 0,
    spec = {
      {
        mode = { 'n', 'v' },
        { 'g', group = 'goto' },
        { '<leader><tab>', group = 'tabs' },
        { '<leader>b', group = '[B]uffer' },
        { '<leader>c', group = '[C]ode' },
        { '<leader>e', group = '[E]xplorer' },
        { '<leader>f', group = 'file/find' },
        { '<leader>g', group = 'git' },
        { '<leader>gh', group = 'hunks' },
        { '<leader>q', group = 'quit/session' },
        { '<leader>r', group = '[R]ename' },
        { '<leader>s', group = '[S]earch' },
        { '<leader>t', group = '[T]oggle' },
        { '<leader>u', group = 'ui' },
        { '<leader>w', group = '[W]orkspace' },
        { '<leader>x', group = 'diagnostics/quickfix' },
        { '[', group = 'prev' },
        { ']', group = 'next' },
        { 'g', group = 'goto' },
        { 'gs', group = 'surround' },
        { 'z', group = 'fold' },
      },
    },
  },
}
