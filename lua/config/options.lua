-- Set <space> as the leader key
-- Must happen before plugins are required (otherwise wrong leader will be used)
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
vim.o.hlsearch = true -- Set highlight on search
vim.wo.number = true -- Make line numbers default
vim.o.mouse = 'a' -- Enable mouse mode
vim.o.clipboard = 'unnamedplus' -- Sync clipboard between OS and Neovim.
vim.o.breakindent = true -- Enable break indent
vim.o.undofile = true -- Save undo history
vim.o.ignorecase = true -- Case-insensitive searching UNLESS \C or capital in search
vim.o.smartcase = true -- If you include mixed case in your search
vim.wo.signcolumn = 'yes' -- Keep signcolumn on by default
vim.o.updatetime = 250 -- Decrease update time
vim.o.timeout = true -- Nvim will wait for any key that can follow in a mapping
vim.o.timeoutlen = 200 -- Time in milliseconds to wait for a mapped sequence to complete
vim.o.completeopt = 'menuone,noselect' -- Set completeopt to have a better completion experience
vim.o.termguicolors = true -- You should make sure your terminal supports this
vim.o.confirm = true -- Confirm before pressing :q with unsaved changes
vim.o.expandtab = true -- Expand tab to spaces
vim.o.relativenumber = true -- Show relative line numbers
vim.o.shiftwidth = 2 -- 2 spaces for indent width
vim.o.tabstop = 2 -- Set tab stops
