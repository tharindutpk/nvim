-- Entry point. See README.md for the layout of this config.
--
-- The leader keys must be set before any mapping is defined, so they live here
-- rather than in lua/config/options.lua.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config") -- options, keymaps, autocmds
require("plugins") -- plugin specs and their setup
require("config.lsp") -- last: needs blink.cmp's completion capabilities
