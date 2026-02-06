-- keymaps
-- :help vim.keymap.set()

local map = vim.keymap.set

-- escape
map('i', 'jk', '<Esc>', { desc = 'Exit insert mode' })
map('t', 'jk', '<C-\\><C-n>', { desc = 'Exit terminal mode (alt)' })

-- package
map('n', '<leader>ps', '<cmd>lua vim.pack.update()<CR>', { desc = 'Update packages' })

-- search
map('n', '<Esc>', '<cmd>nohlsearch<CR>', { desc = 'Clear search highlight' })

-- diagnostics
map('n', '<leader>q', vim.diagnostic.setloclist, { desc = 'Open diagnostics list' })

-- terminal
map('t', '<Esc><Esc>', '<C-\\><C-n>', { desc = 'Exit terminal mode' })

-- windows
map('n', '<C-h>', '<C-w><C-h>', { desc = 'Focus left window' })
map('n', '<C-l>', '<C-w><C-l>', { desc = 'Focus right window' })
map('n', '<C-j>', '<C-w><C-j>', { desc = 'Focus lower window' })
map('n', '<C-k>', '<C-w><C-k>', { desc = 'Focus upper window' })
