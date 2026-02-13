vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})

require("catppuccin").setup({
  favour = "mocha",
  no_italic = true,
  integrations = {
    blink_cmp = true,
    fidget = true,
    fzf = true,
    mason = true,
    lsp_trouble = true,
    snacks = true,
  },
  compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
})

vim.cmd.colorscheme("catppuccin")
