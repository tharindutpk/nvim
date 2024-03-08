-- [[ Basic Keymaps ]]
vim.keymap.set('i', 'jk', '<ESC>')
vim.keymap.set('t', 'jk', '<C-\\><C-n>')

-- Clear highlight on pressing <Esc> in normal mode
vim.keymap.set('n', '<Esc>', '<cmd>nohlsearch<CR>')
