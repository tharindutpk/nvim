-- Set <space> as the leader key
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

-- [[ Setting options ]]
require('config.options')

-- [[ Basic Keymaps ]]
require('config.keymaps')

-- [[ Autocommands ]]
require('config.autocmds')

-- [[ Install lazy.nvim plugin manager ]]
require('config.lazy')

-- The line beneath this is called `modeline`. See `:help modeline`
-- vim: ts=2 sts=2 sw=2 et
