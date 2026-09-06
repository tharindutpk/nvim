---@type vim.lsp.Config
return {
  cmd = { "svelteserver", "--stdio" },
  filetypes = { "svelte" },
  root_markers = { "svelte.config.js", "svelte.config.mjs", "package.json", ".git" },
  settings = {
    svelte = {
      plugin = {
        -- Formatting is conform's job (prettierd), so the server should stay
        -- out of it and only report diagnostics.
        svelte = { format = { enable = false } },
      },
    },
  },
}
