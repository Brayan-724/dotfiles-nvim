local colors = require "apika.theme.colors"

local highlights = {
  RenamerTitle = { fg = colors.nebula11, bg = "NONE" },
  RenamerBorder = { fg = colors.nebula11 },
}

require("apika.theme.utils").set_highlights(highlights)
