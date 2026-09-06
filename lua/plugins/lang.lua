vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" }, -- required by typescript-tools
  { src = "https://github.com/pmizio/typescript-tools.nvim" },
  { src = "https://github.com/mrcjkb/rustaceanvim" }, -- configured via vim.g, no setup() call
})

-- typescript-tools registers itself as an LSP config and calls vim.lsp.enable(),
-- which re-runs FileType for open buffers -- so deferring it still attaches to
-- the file Nvim started with.
require("util.lazy").later(function()
  require("typescript-tools").setup({})
end)
