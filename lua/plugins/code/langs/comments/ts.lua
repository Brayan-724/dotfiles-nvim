-- vim.treesitter.language.register("comments", "dtxt")
-- vim.treesitter.language.register("comments", "*")

return {
  install_info = {
    -- url = "~/gh/tree-sitter-comments",
    url = "https://github.com/OXY2DEV/tree-sitter-comment",
    files = { "src/parser.c", "src/scanner.c" },
    revision = "87bb8707b694e7d9820947f21be36d6ce769e5cc",
    queries = "queries/"
  },
  maintainers = { "@OXY2DEV" },
}
