local colors = require "apika.theme.colors"

return {
  ["@punctuation.delimiter.comment"] = { fg = colors.nord_blue, bold = true },
  ["@markup.raw.comment"] = { fg = "white", bg = colors.space2 },
  ["@markup.italic.comment"] = { fg = colors.astral1, italic = true, bold = false },
  ["@markup.strong.comment"] = { fg = colors.astral1, bold = true },

  ["@extmark.comment.mention"] = { fg = colors.nebula11, bold = true },
  ["@extmark.comment.issue"] = { fg = colors.vibrant_green, bold = true },

  ["@extmark.comment.code"] = { link = "@markup.raw.comment" },
  ["@extmark.comment.code.border"] = { fg = colors.term_background, bg = colors.space2  },
  ["@extmark.comment.code.border.inverted"] = { fg = colors.space2, bg = "none"  },
  ["@extmark.comment.code.author"] = { fg = colors.white, bg = colors.space2, bold = true  },
  ["@extmark.comment.code.label"] = { fg = "white", bg = colors.darker_black, bold = true },

  ["@extmark.comment.task"] = { bg = colors.space3 },
  ["@extmark.comment.task.border"] = { fg = colors.space3 },
  ["@extmark.comment.task.todo"] = { fg = colors.blue, bg = colors.space3 },
  ["@extmark.comment.task.error"] = { fg = colors.red, bg = colors.space3 },
  ["@extmark.comment.task.warning"] = { fg = colors.yellow, bg = colors.space3 },
  ["@extmark.comment.task.note"] = { fg = colors.cyan, bg = colors.space3 },
  ["@extmark.comment.task.bug"] = { fg = colors.baby_pink, bg = colors.space3 },
  ["@extmark.comment.task.hack"] = { fg = colors.vibrant_green, bg = colors.space3 },
  ["@extmark.comment.task.perf"] = { fg = colors.sun, bg = colors.space3 },
}
