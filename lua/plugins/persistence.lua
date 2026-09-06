vim.pack.add({
  { src = "https://github.com/folke/persistence.nvim" },
})

-- persistence saves the session on VimLeavePre; setting it up right after
-- startup is early enough, and restoring is always explicit.
require("util.lazy").later(function()
  require("persistence").setup({})
end)

local map = vim.keymap.set

map("n", "<leader>Ss", function()
  require("persistence").load()
end, { desc = "Restore session for this directory" })

map("n", "<leader>Sl", function()
  require("persistence").load({ last = true })
end, { desc = "Restore last session" })

map("n", "<leader>Sd", function()
  require("persistence").stop()
end, { desc = "Do not save this session" })
