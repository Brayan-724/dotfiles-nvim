vim.filetype.add {
  extension = {
    aml3 = "aml3",
  },
}

return {
  install_info = {
    url = "~/projects/tree-sitter-aml3",
    files = { "src/parser.c" },
  },
}

