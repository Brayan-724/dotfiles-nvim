--- format & linting

return {
  "nvimtools/none-ls.nvim",
  name = "null-ls",
  config = function(_, sources)
    require "null-ls".setup {
      debug = false,
      sources = sources,
    }
  end,
}
