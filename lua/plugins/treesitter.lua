vim.pack.add({
  { src = "https://github.com/nvim-treesitter/nvim-treesitter-context" },
  { src = "https://github.com/windwp/nvim-ts-autotag" },
  { src = "https://github.com/nvim-treesitter/nvim-treesitter", version = "main" },
  { src = "https://github.com/MeanderingProgrammer/treesitter-modules.nvim" },
})

local ensure_languages = {
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
}

require("treesitter-modules").setup({
  ensure_installed = ensure_languages,
  auto_install = true,
  highlight = {
    enable = true,
  },
  indent = {
    enable = true,
  },
  incremental_selection = {
    enable = true,
  },
})

vim.api.nvim_create_autocmd({ "PackChanged" }, {
  callback = function(args)
    local spec = args.data.spec
    if spec and spec.name == "nvim-treesitter" and args.data.kind == "update" then
      vim.schedule(function()
        vim.cmd("TSUpdate")
      end)
    end
  end,
})

require("treesitter-context").setup({
  mode = "topline",
  max_lines = 2,
})

require("nvim-ts-autotag").setup({})
