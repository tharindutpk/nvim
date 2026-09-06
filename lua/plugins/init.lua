-- Plugins are loaded in dependency order, not alphabetically:
--   * the colorscheme first, so everything else can theme against it;
--   * which-key last, so its groups are registered after every mapping exists.
--
-- Each file adds its plugin with `vim.pack.add()` and then either configures it
-- immediately or hands the configuration to util.lazy. See README.md.

-- appearance and core editing
require("plugins.catppuccin")
require("plugins.treesitter")
require("plugins.snacks")

-- tooling
require("plugins.fzf")
require("plugins.mason")
require("plugins.blink")
require("plugins.conform")
require("plugins.lint")
require("plugins.gitsigns")
require("plugins.diffview")

-- ui chrome
require("plugins.lualine")
require("plugins.bufferline")

-- files and terminals
require("plugins.nvim-tree")
require("plugins.oil")
require("plugins.toggleterm")

-- editing helpers
require("plugins.autopairs")
require("plugins.util")
require("plugins.persistence")
require("plugins.lang")

require("plugins.which-key")
