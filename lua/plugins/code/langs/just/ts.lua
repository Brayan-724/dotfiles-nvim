vim.filetype.add {
  extension = {
    just = "just",
  },
}

return {
  install_info = {
    url = "https://github.com/IndianBoy42/tree-sitter-just",
    files = { "src/parser.c", "src/scanner.c" },
    branch = "main",
    -- use_makefile = true -- this may be necessary on MacOS (try if you see compiler errors)
  },
  maintainers = { "@IndianBoy42" },
}
