vim.pack.add({
  { src = "https://github.com/nvim-lua/plenary.nvim" },
  { src = "https://github.com/sindrets/diffview.nvim" },
})

-- diffview already defers its own heavy modules -- its plugin/ file registers
-- the commands and only pulls the rest in on first use -- so setup() runs at
-- `later()` rather than from a keymap. That way `:DiffviewOpen` typed by hand
-- behaves exactly like the mappings below.
require("util.lazy").later(function()
  require("diffview").setup({
    enhanced_diff_hl = true,
    view = {
      -- Three-way conflict layout: local and remote either side of the working
      -- copy, which is the only sane way to resolve a merge.
      merge_tool = {
        layout = "diff3_mixed",
        disable_diagnostics = true,
      },
    },
    file_panel = {
      listing_style = "tree",
      win_config = { width = 32 },
    },
    keymaps = {
      view = {
        { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
      },
      file_panel = {
        { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
      },
      file_history_panel = {
        { "n", "q", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" } },
      },
    },
  })
end)

local map = vim.keymap.set

map("n", "<leader>gd", "<cmd>DiffviewOpen<CR>", { desc = "Diff working tree" })
map("n", "<leader>gm", "<cmd>DiffviewOpen origin/HEAD...HEAD<CR>", { desc = "Diff against merge base" })
map("n", "<leader>gh", "<cmd>DiffviewFileHistory %<CR>", { desc = "History of this file" })
map("n", "<leader>gH", "<cmd>DiffviewFileHistory<CR>", { desc = "History of this branch" })
map("v", "<leader>gh", "<Esc><cmd>'<,'>DiffviewFileHistory<CR>", { desc = "History of selection" })
map("n", "<leader>gq", "<cmd>DiffviewClose<CR>", { desc = "Close diffview" })
