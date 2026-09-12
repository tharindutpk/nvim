-- Stamped first so the dashboard can report how long the config took to load.
-- This measures from here to the first dashboard render, so it excludes the few
-- milliseconds Nvim spends on its own init before reading this file.
vim.g.start_time = vim.uv.hrtime()

-- Entry point. See README.md for the layout of this config.
--
-- The leader keys must be set before any mapping is defined, so they live here
-- rather than in lua/config/options.lua.
vim.g.mapleader = " "
vim.g.maplocalleader = " "

require("config") -- options, keymaps, autocmds
require("plugins") -- plugin specs and their setup
require("config.lsp") -- last: needs blink.cmp's completion capabilities

-- Record which plugins the lines above actually loaded, for the dashboard
-- footer. Must be the last statement here -- see util.lazy.snapshot().
require("util.lazy").snapshot()
