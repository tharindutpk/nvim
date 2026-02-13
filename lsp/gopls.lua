--- @type vim.lsp.Config
return {
  cmd = { "gopls" },
  filetypes = { "go", "gomod", "gowork", "gotmpl" },
  root_markers = { ".git", "go.mod" },
  settings = {
    gopls = {
      gofumpt = true,
    },
  },
}
