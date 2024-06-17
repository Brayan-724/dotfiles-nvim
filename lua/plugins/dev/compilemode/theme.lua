local colors = require "apika.theme.colors"

return {
  CompileModeError = { underline = false, bold = true },
  CompileModeErrorCol = { fg = colors.green, bg = "NONE", underline = false },
  CompileModeErrorRow = { fg = colors.green, bg = "NONE", underline = false },
  CompileModeInfoFilename = { fg = colors.blue, bg = "NONE", underline = false },
  CompileModeErrorFilename = { fg = colors.red, bg = "NONE", underline = false },
  CompileModeWarningFilename = { fg = colors.yellow, bg = "NONE", underline = false },
}
