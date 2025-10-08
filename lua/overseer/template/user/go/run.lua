return {
  name = 'Go Run',
  desc = 'Run Go file',
  builder = function()
    local file = vim.fn.expand('%:p')
    return {
      cmd = { 'go', 'run', file },
      components = {
        'output',
      },
    }
  end,
  condition = {
    filetype = { 'go' },
  },
  priority = -1,
}
