local colors = require "apika.theme.colors"

local highlights = {
  WinBar = { bg = colors.term_background, fg = colors.term_background },
  WinBarNC = { bg = colors.term_background, fg = colors.term_background },
}

require("apika.theme.utils").set_highlights(highlights)
