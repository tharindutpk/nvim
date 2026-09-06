vim.pack.add({
  -- Track the latest 1.x release rather than pinning a single tag, so patch
  -- fixes arrive with `vim.pack.update()` but a 2.0 cannot land unannounced.
  { src = "https://github.com/saghen/blink.cmp", version = vim.version.range("1") },
})

-- Deferred, but still before anything calls vim.lsp.enable() -- see the ordering
-- note in lua/plugins/init.lua -- so every server starts with blink's
-- completion capabilities attached.
require("util.lazy").later(function()
  require("blink.cmp").setup({
    keymap = {
      preset = "enter",
      ["<Tab>"] = { "select_next", "fallback" },
      ["<S-Tab>"] = { "select_prev", "fallback" },
    },
    appearance = {
      nerd_font_variant = "mono",
    },
    completion = {
      documentation = { auto_show = true },
    },
    sources = {
      default = { "lsp", "path", "snippets", "buffer" },
    },
    fuzzy = { implementation = "prefer_rust_with_warning" },
    signature = { enabled = true },
  })

  -- blink does not register these itself, so without this every server would
  -- fall back to Nvim's built-in capabilities and lose snippet support,
  -- resolve support and insert/replace completions.
  vim.lsp.config("*", {
    capabilities = require("blink.cmp").get_lsp_capabilities(nil, true),
  })
end)
