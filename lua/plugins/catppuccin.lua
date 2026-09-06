vim.pack.add({
  { src = "https://github.com/catppuccin/nvim", name = "catppuccin" },
})

require("catppuccin").setup({
  flavour = "mocha",
  no_italic = true,
  -- `default_integrations` already covers blink_cmp, blink_indent, fzf,
  -- gitsigns, nvimtree and treesitter_context; only the ones that ship
  -- disabled need listing here.
  integrations = {
    diffview = true,
    fidget = true,
    mason = true,
    nvim_surround = true,
    snacks = true,
    which_key = true,
  },
  compile_path = vim.fn.stdpath("cache") .. "/catppuccin",
})

vim.cmd.colorscheme("catppuccin")
