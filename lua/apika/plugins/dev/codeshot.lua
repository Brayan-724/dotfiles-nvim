return {
  "SergioRibera/codeshot.nvim",
  -- dir = "~/Downloads/codeshot.nvim/",
  opts = {
    copy = "%c | xclip -selection clipboard -t image/png",
    -- copy = "%c | xclip -selection clipboard",
    silent = true,
    use_current_theme = true,
    author = "Apika Luca",
    window_controls = true,
    -- background = require("apika.theme.colors").term_background,
    shadow = true,
  },
  config = function (_, opts)
    require("codeshot").setup(opts)
  end
}
