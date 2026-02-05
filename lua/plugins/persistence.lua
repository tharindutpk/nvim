vim.pack.add({ 'https://github.com/folke/persistence.nvim' })

require('persistence').setup({})

-- load the last session
vim.keymap.set('n', '<leader>ql', function()
  require('persistence').load({ last = true })
end)
