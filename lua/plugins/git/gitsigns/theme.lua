local colors = require "apika.theme.colors"

return {
  GitSignsAdd = { fg = colors.red, bg = colors.term_background },
  GitSignsChange = { fg = colors.green, bg = colors.term_background },
  GitSignsDelete = { fg = colors.yellow, bg = colors.term_background },
  GitSignsTopDelete = { fg = colors.yellow, bg = colors.term_background },
  GitSignsChangeDelete = { fg = colors.red, bg = colors.term_background },
  GitSignsUntracked = { fg = colors.blue, bg = colors.term_background },
}
