vim.pack.add({
  { src = "https://github.com/mfussenegger/nvim-lint" },
})

local lazy = require("util.lazy")

local setup = lazy.once(function()
  local lint = require("lint")

  -- biome is the JS/TS linter here; prettierd still owns formatting, so biome
  -- never needs a biome.json to be useful -- with no config it lints against
  -- its recommended rules.
  local biome = { "biomejs" }

  lint.linters_by_ft = {
    bash = { "shellcheck" },
    javascript = biome,
    javascriptreact = biome,
    json = biome,
    markdown = { "markdownlint" },
    sh = { "shellcheck" },
    svelte = biome,
    typescript = biome,
    typescriptreact = biome,
  }

  return lint
end)

local function try_lint()
  if vim.bo.modifiable and vim.bo.buftype == "" then
    setup().try_lint()
  end
end

lazy.later(function()
  vim.api.nvim_create_autocmd({ "BufReadPost", "BufWritePost", "InsertLeave" }, {
    group = vim.api.nvim_create_augroup("tharindutpk_lint", { clear = true }),
    desc = "Run linters for the current file",
    callback = try_lint,
  })

  try_lint()
end)

vim.keymap.set("n", "<leader>l", try_lint, { desc = "Lint current file" })
