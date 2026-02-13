vim.pack.add({
  { src = "https://github.com/nvim-tree/nvim-web-devicons" },
  { src = "https://github.com/nvim-lualine/lualine.nvim" },
})

require("lualine").setup({
  options = {
    theme = "catppuccin",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = { "NVimTree", "snacks_dashboard" },
  },
  sections = {
    lualine_a = { "mode" },
    lualine_b = { "branch" },
    lualine_c = { { "filename", file_status = true, path = 1 } },
    lualine_x = { "diff", "diagnostics", "encoding", "fileformat", "filetype" },
  },
  extensions = { "lazy", "mason", "nvim-tree", "toggleterm" },
})
