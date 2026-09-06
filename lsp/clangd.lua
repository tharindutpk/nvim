---@type vim.lsp.Config
return {
  cmd = { "clangd" },
  filetypes = { "c", "cpp" },
  root_markers = {
    "compile_commands.json",
    "compile_flags.txt",
    ".clangd",
    "Makefile",
    "CMakeLists.txt",
    ".git",
  },
}
