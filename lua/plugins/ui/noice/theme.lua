local colors = require "apika.theme.colors"

return {
  NotifyBackground = { bg = colors.float_background },

  NotifyERRORBody = { bg = colors.float_background },
  NotifyWARNBody = { bg = colors.float_background },
  NotifyWARNBody2 = { bg = colors.float_background },
  NotifyINFOBody = { bg = colors.float_background },
  NotifyDEBUGBody = { bg = colors.float_background },
  NotifyTRACEBody = { bg = colors.float_background },

  NotifyERRORBorder = { fg = "#8A1F1F", bg = colors.float_background },
  NotifyWARNBorder = { fg = "#79491D", bg = colors.float_background },
  NotifyINFOBorder = { fg = "#4F6752", bg = colors.float_background },
  NotifyDEBUGBorder = { fg = "#8B8B8B", bg = colors.float_background },
  NotifyTRACEBorder = { fg = "#4F3552", bg = colors.float_background },

  NotifyERRORIcon = { fg = "#F70067", bg = colors.float_background },
  NotifyWARNIcon = { fg = "#F79000", bg = colors.float_background },
  NotifyINFOIcon = { fg = "#A9FF68", bg = colors.float_background },
  NotifyDEBUGIcon = { fg = "#8B8B8B", bg = colors.float_background },
  NotifyTRACEIcon = { fg = "#D484FF", bg = colors.float_background },

  NotifyERRORTitle = { fg = "#F70067", bg = colors.float_background },
  NotifyWARNTitle = { fg = "#F79000", bg = colors.float_background },
  NotifyINFOTitle = { fg = "#A9FF68", bg = colors.float_background },
  NotifyDEBUGTitle = { fg = "#8B8B8B", bg = colors.float_background },
  NotifyTRACETitle = { fg = "#D484FF", bg = colors.float_background },
}
