---@type vim.lsp.Config
return {
  cmd = { "bash-language-server", "start" },
  filetypes = { "sh", "bash" },
  root_markers = { ".git" },
  settings = {
    bashIde = {
      -- shellcheck runs through nvim-lint instead, so the server does not
      -- need to shell out to it as well.
      shellcheckPath = "",
    },
  },
}
