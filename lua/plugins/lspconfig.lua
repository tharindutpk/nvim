vim.pack.add({
  { src = "https://github.com/mason-org/mason.nvim.git" },
  { src = "https://github.com/j-hui/fidget.nvim" },
  { src = "https://github.com/WhoIsSethDaniel/mason-tool-installer.nvim" },
})

local ensure_installed = {
  -- Language servers
  "clangd",
  "gopls",
  "lua-language-server",
  "ty",
  "typescript-language-server",

  -- Formatters / linters
  "biome",
  "clang-format",
  "eslint_d",
  "gofumpt",
  "goimports",
  "prettierd",
  "ruff",
  "shfmt",
  "stylua",
  "markdownlint",
}

require("mason").setup()
require("fidget").setup()
require("mason-tool-installer").setup({
  ensure_installed = ensure_installed,
})
