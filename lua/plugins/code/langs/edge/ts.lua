vim.filetype.add {
  extension = {
    edge = "edge",
  },
}

return {
  install_info = {
    url = "~/projects/tree-sitter-edge",
    files = { "src/parser.c" },
  },
}


