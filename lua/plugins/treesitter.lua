vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/MeanderingProgrammer/treesitter-modules.nvim" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
})

-- Highlighting has to be configured before the first buffer is drawn, so this
-- one stays on the startup path. Parsers themselves load lazily per filetype.
require("treesitter-modules").setup({
  ensure_installed = {
    "c",
    "cpp",
    "css",
    "diff",
    "go",
    "gomod",
    "gosum",
    "gowork",
    "html",
    "javascript",
    "lua",
    "luadoc",
    "markdown",
    "markdown_inline",
    "python",
    "query",
    "regex",
    "rust",
    "svelte",
    "templ",
    "toml",
    "tsx",
    "typescript",
    "vim",
    "vimdoc",
    "yaml",
  },
  auto_install = true,
  highlight = { enable = true },
  indent = { enable = true },
  incremental_selection = { enable = true },
})

-- Recompile parsers whenever nvim-treesitter itself is updated, otherwise the
-- ABI can drift out of sync with the installed parsers.
vim.api.nvim_create_autocmd("PackChanged", {
  group = vim.api.nvim_create_augroup("tharindutpk_treesitter_update", { clear = true }),
  desc = "Run :TSUpdate after nvim-treesitter changes",
  callback = function(args)
    local spec = args.data.spec

    if spec and spec.name == "nvim-treesitter" and args.data.kind == "update" then
      vim.schedule(function()
        vim.cmd("TSUpdate")
      end)
    end
  end,
})

require("util.lazy").later(function()
  require("treesitter-context").setup({
    mode = "topline",
    max_lines = 2,
  })

  require("nvim-ts-autotag").setup({})
end)
