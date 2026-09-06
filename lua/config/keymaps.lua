-- Global mappings. `:help vim.keymap.set()`
--
-- Mappings that only make sense with a plugin loaded live next to that plugin
-- in lua/plugins/, so that they can pull it in on first use.
local map = vim.keymap.set

-- escape
map("i", "jk", "<Esc>", { desc = "Exit insert mode" })
map("t", "jk", "<C-\\><C-n>", { desc = "Exit terminal mode (alt)" })
map("t", "<Esc><Esc>", "<C-\\><C-n>", { desc = "Exit terminal mode" })

-- search
map("n", "<Esc>", "<cmd>nohlsearch<CR>", { desc = "Clear search highlight" })

-- diagnostics
map("n", "<leader>q", vim.diagnostic.setloclist, { desc = "Open diagnostics list" })

-- windows
map("n", "<C-h>", "<C-w><C-h>", { desc = "Focus left window" })
map("n", "<C-l>", "<C-w><C-l>", { desc = "Focus right window" })
map("n", "<C-j>", "<C-w><C-j>", { desc = "Focus lower window" })
map("n", "<C-k>", "<C-w><C-k>", { desc = "Focus upper window" })

-- toggles
map("n", "<leader>tl", function()
  vim.o.list = not vim.o.list
end, { desc = "Toggle whitespace" })

map("n", "<leader>tw", function()
  vim.o.wrap = not vim.o.wrap
end, { desc = "Toggle line wrap" })

-- packages (vim.pack)
map("n", "<leader>ps", function()
  vim.pack.update()
end, { desc = "Update packages" })

map("n", "<leader>pl", function()
  vim.pack.update(nil, { offline = true })
end, { desc = "List packages (offline)" })
