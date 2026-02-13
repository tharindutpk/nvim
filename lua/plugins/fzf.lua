vim.pack.add({
  { src = "https://github.com/ibhagwan/fzf-lua" },
})

require("fzf-lua").setup({
  winopts = {
    height = 0.80,
    width = 0.80,
    row = 0.5,
    backdrop = 60,
  },
})

local fzf = require("fzf-lua")
vim.keymap.set("n", "<leader>sh", fzf.help_tags, { desc = "Search help" })
vim.keymap.set("n", "<leader>sk", fzf.keymaps, { desc = "Search keymaps" })
vim.keymap.set("n", "<leader>sf", fzf.files, { desc = "Search files" })
vim.keymap.set("n", "<leader>sw", fzf.grep_cword, { desc = "Search current word" })
vim.keymap.set("n", "<leader>sg", fzf.live_grep_native, { desc = "Search by grep" })
vim.keymap.set("n", "<leader>sl", function()
  fzf.grep({ resume = true })
end, { desc = "Search by last" })
vim.keymap.set("n", "<leader>sd", fzf.lsp_document_diagnostics, { desc = "Search diagnostics" })
vim.keymap.set("n", "<leader>so", function()
  fzf.oldfiles({
    cwd_only = true,
  })
end, { desc = "Search old files" })
vim.keymap.set("n", "<leader>s/", fzf.buffers, { desc = "Search in open files" })
vim.keymap.set("n", "<leader>sn", function()
  fzf.files({ cwd = vim.fn.stdpath("config") })
end, { desc = "Search neovim files" })
vim.keymap.set("n", "<leader>/", fzf.grep_curbuf, { desc = "Fuzzily search in current buffer" })
vim.keymap.set("n", "<leader><leader>", fzf.buffers, { desc = "Find existing buffers" })
