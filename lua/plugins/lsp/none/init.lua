--- format & linting

return {
  "nvimtools/none-ls.nvim",
  config = function(_, sources)
    require "null-ls".setup {
      debug = false,
      sources = sources,
    }
  end,
}
