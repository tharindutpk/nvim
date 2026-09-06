-- Editor options. `:help option-list`
--
-- `vim.o` is the whole story since Nvim 0.11: it accepts the same values the
-- option takes in `:set`, including list- and map-style options, so there is no
-- reason to mix in `vim.opt` any more.
local o = vim.o

-- ui
o.number = true -- line numbers
o.relativenumber = true -- relative numbers
o.cursorline = true -- highlight current line
o.scrolloff = 10 -- keep context while scrolling
o.signcolumn = "yes" -- always show signs, so text never shifts
o.showmode = false -- lualine already shows the mode
o.winborder = "solid" -- border for floats (hover, diagnostics, pickers)

-- input
o.mouse = "a" -- enable mouse

-- Resolving the clipboard provider shells out, which is measurable at startup.
-- Deferring it costs nothing: no yank can happen before the first screen draw.
vim.schedule(function()
  o.clipboard = "unnamedplus" -- sync system clipboard
end)

-- editing
o.shiftwidth = 2 -- indent width
o.tabstop = 2 -- tab width
o.breakindent = true -- keep indent on wrapped lines
o.undofile = true -- persistent undo

-- search
o.ignorecase = true -- case-insensitive search
o.smartcase = true -- unless the pattern has uppercase

-- windows
o.splitright = true -- vertical splits open to the right
o.splitbelow = true -- horizontal splits open below

-- behaviour
o.list = false -- hide whitespace by default (toggled by <leader>tl)
o.listchars = "tab:» ,trail:·,nbsp:␣" -- how whitespace renders when shown
o.updatetime = 250 -- faster CursorHold (document highlight, diagnostics)
o.timeoutlen = 300 -- faster which-key / mapping timeout
o.inccommand = "split" -- live preview of :substitute
o.confirm = true -- prompt instead of failing on unsaved quit
