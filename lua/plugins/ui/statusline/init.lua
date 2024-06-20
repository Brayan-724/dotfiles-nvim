return {
  dir = "~/dev/am.statusline/",
  name = "am.statusline",
  config = function()
    require("am.statusline").setup {
      theme = "apika"
    }
  end,
}
