vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/catppuccin/nvim" },
  { src = "https://github.com/akinsho/bufferline.nvim" },
})

require("bufferline").setup({
  options = {
    show_buffer_close_icons = false,
    offsets = {
      {
        filetype = "NvimTree",
        highlight = "Directory",
        separator = true,
        text = "File Explorer",
      },
    },
  },
  highlights = require("catppuccin.special.bufferline").get_theme(),
})

vim.keymap.set("n", "<leader>bo", "<cmd>BufferLineCloseOthers<CR>", { desc = "Delete other buffers" })
vim.keymap.set("n", "<leader>br", "<cmd>BufferLineCloseRight<CR>", { desc = "Delete buffers to the right" })
vim.keymap.set("n", "<leader>bl", "<cmd>BufferLineCloseLeft<CR>", { desc = "Delete buffers to the left" })
vim.keymap.set("n", "<S-h>", "<cmd>BufferLineCyclePrev<CR>", { desc = "Prev buffer" })
vim.keymap.set("n", "<S-l>", "<cmd>BufferLineCycleNext<CR>", { desc = "Next buffer" })
