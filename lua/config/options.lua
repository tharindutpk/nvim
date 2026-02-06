-- options
-- :help vim.opt

local opt = vim.opt
local o = vim.o

-- ui
opt.number = true -- line numbers
opt.relativenumber = true -- relative numbers
opt.cursorline = true -- highlight current line
opt.scrolloff = 10 -- keep context while scrolling
opt.signcolumn = 'yes' -- always show signs
opt.showmode = false -- hide mode (statusline handles it)

-- input
opt.mouse = 'a' -- enable mouse
vim.schedule(function()
  opt.clipboard = 'unnamedplus' -- sync system clipboard
end)

-- editing
o.shiftwidth = 2 -- indent width
o.tabstop = 2 -- tab width
opt.breakindent = true -- indent wrapped lines
opt.undofile = true -- persistent undo

-- search
opt.ignorecase = true -- case-insensitive search
opt.smartcase = true -- uppercase overrides ignorecase

-- windows
opt.splitright = true -- vertical splits to the right
opt.splitbelow = true -- horizontal splits below

-- behavior
opt.list = false -- hide whitespace
opt.listchars = { tab = '» ', trail = '·', nbsp = '␣' } -- whitespace symbols
opt.updatetime = 250 -- faster updates
opt.timeoutlen = 300 -- faster mappings
opt.inccommand = 'split' -- live substitution preview
opt.confirm = true -- confirm on unsaved quit
