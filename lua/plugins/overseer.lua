return {
  'stevearc/overseer.nvim',
  keys = {
    { '<leader>or', ':OverseerRun<CR><CMD>OverseerOpen!<CR>', desc = '[O]verseer [R]un' },
    { '<leader>ot', ':OverseerToggle<CR>', desc = '[O]verseer [T]oggle' },
    { '<leader>oR', ':OverseerRestartLast<CR>', desc = '[O]verseer [R]estart [L]ast' },
  },
  opts = {
    templates = { 'builtin', 'user.go', 'user.cpp' },
    strategy = 'toggleterm',
    component_aliases = {
      output = {
        {
          'open_output',
          on_complete = 'always',
          direction = 'dock',
          focus = true,
        },
      },
    },
  },
  config = function(_, opts)
    local overseer = require('overseer')
    overseer.setup(opts)
  end,
}
