vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
  { src = "https://github.com/j-hui/fidget.nvim" },
})

-- Everything mason installs. Language servers are declared in lsp/<name>.lua,
-- formatters in plugins/conform.lua and linters in plugins/lint.lua -- keep
-- this list in sync with those three.
local ensure_installed = {
  -- language servers
  "bash-language-server",
  "clangd",
  "gopls",
  "lua-language-server",
  "ruff",
  "svelte-language-server",
  "ty",
  "typescript-language-server",

  -- formatters
  "clang-format",
  "gofumpt",
  "goimports",
  "prettierd",
  "shfmt",
  "sql-formatter",
  "stylua",

  -- linters
  "biome",
  "markdownlint",
  "shellcheck",

  -- nvim-treesitter's main branch shells out to the tree-sitter CLI to build
  -- parsers, so it has to be on PATH; mason prepends its bin directory.
  "tree-sitter-cli",
}

require("util.lazy").later(function()
  require("mason").setup()
  require("fidget").setup()

  require("mason-tool-installer").setup({
    ensure_installed = ensure_installed,
    -- mason-tool-installer's own start hook runs on VimEnter, which has
    -- already fired by the time this setup happens, so kick it off by hand.
    run_on_start = false,
  })

  require("mason-tool-installer").check_install(false)
end)
