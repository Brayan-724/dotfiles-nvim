vim.filetype.add {
  extension = {
    nc = "nc",
  },
}

return {
  install_info = {
    url = "~/gh/no-compiler/tree-sitter-nc",
    files = { "src/parser.c" },
  },
}

