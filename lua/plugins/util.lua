vim.pack.add({
  { src = "https://github.com/kylechui/nvim-surround" },
  { src = "https://github.com/rmagatti/alternate-toggler" },
  { src = "https://github.com/saghen/blink.indent" },
})

local lazy = require("util.lazy")

lazy.later(function()
  require("nvim-surround").setup({})

  require("blink.indent").setup({
    static = { char = "│" },
    scope = {
      char = "│",
      highlights = { "BlinkIndentScope" },
    },
  })
end)

-- Only needed the moment the mapping is pressed.
local setup_alternate = lazy.once(function()
  require("alternate-toggler").setup({})
end)

vim.keymap.set("n", "<leader>ta", function()
  setup_alternate()
  vim.cmd("ToggleAlternate")
end, { desc = "Toggle alternate (true/false, ==/~=, ...)" })
