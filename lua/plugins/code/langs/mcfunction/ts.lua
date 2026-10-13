vim.filetype.add {
  extension = {
    mcfunction = "mcfunction"
  },
}

return {
  install_info = {
    url = "https://github.com/phoenixr-codes/tree-sitter-mcfunction.git",
    files = { "src/parser.c" },
    branch = "main",
  },
}
