vim.pack.add({
  { src = "https://github.com/stevearc/conform.nvim" },
})

require("conform").setup({
  format_on_save = function(bufnr)
    if vim.g.disable_autoformat or vim.b[bufnr].disable_autoformat then
      return
    end
    return { timeout_ms = 500, lsp_format = "fallback" }
  end,
  formatters_by_ft = {
    css = { "prettierd" },
    cpp = { "clang_format" },
    go = { "goimports", "gofumpt" },
    html = { "prettierd" },
    javascript = { "prettierd" },
    javascriptreact = { "prettierd" },
    json = { "prettierd" },
    jsonc = { "prettierd" },
    lua = { "stylua" },
    markdown = { "prettierd" },
    python = { "ruff_organize_imports", "ruff_format" },
    sh = { "shfmt" },
    typescript = { "prettierd" },
    typescriptreact = { "prettierd" },
    yaml = { "prettierd" },
  },
})

vim.keymap.set("n", "<leader>fb", function()
  require("conform").format({
    async = true,
    lsp_format = "fallback",
  })
end, { desc = "Format buffer" })

vim.keymap.set("n", "<leader>ci", "<cmd>ConformInfo<CR>", { desc = "Conform info" })

vim.keymap.set("n", "<leader>tf", function()
  if not vim.b.disable_autoformat and not vim.g.disable_autoformat then
    vim.b.disable_autoformat = true
    print("Autoformat disabled (buffer)")
  elseif vim.b.disable_autoformat then
    vim.b.disable_autoformat = nil
    vim.g.disable_autoformat = true
    print("Autoformat disabled (global)")
  else
    vim.g.disable_autoformat = nil
    vim.b.disable_autoformat = nil
    print("Autoformat enabled")
  end
end, { desc = "Toggle autoformat" })
