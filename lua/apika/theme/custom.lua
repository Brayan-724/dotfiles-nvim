local colors = require "apika.theme.colors"

local highlights = {
  Comment = { fg = colors.nord_blue, bold = true },
  Constant = { fg = colors.dark_purple },
  Conditional = { fg = colors.green },
  Define = { fg = colors.nebula11 },
  FloatBorder = { fg = colors.nebula11, bg = colors.term_background },
  Identifier = { fg = colors.red },
  Keyword = { fg = colors.nebula11 },
  Normal = { bg = colors.term_background },
  NormalFloat = { bg = colors.term_background },
  Macro = { fg = colors.dark_purple },
  PreProc = { fg = colors.purple },
  Repeat = { link = "Keyword" },
  Structure = { fg = colors.purple },
  Type = { fg = colors.darkred },
  Typedef = { fg = colors.purple },
  Variable = { link = "Identifier" },

  ["@field"] = { fg = colors.astral1 },
  ["@parameter"] = { link = "Variable" },
  ["@string"] = { fg = colors.darkgreen },
  ["@type.definition"] = { link = "Keyword" },
  ["@variable"] = { link = "Variable" },

  ColorColumn = { bg = colors.term_background, fg = colors.white },
  CursorColumn = { link = "ColorColumn" },
  CursorLine = { underline = true, bold = true },
  CursorLineFold = { bg = colors.term_background, fg = colors.red },
  CursorLineNr = { bg = colors.term_background, fg = colors.red, bold = true, underline = true },
  CursorLineSign = { bg = colors.term_background, fg = colors.red },

  LineNr = { bg = colors.term_background, fg = "#eeeeee", bold = true },
  SignColumn = { link = "ColorColumn" },
  WinSeparator = { fg = colors.nebula11 },

  Folded = { fg = colors.yellow },
  FoldColumn = { bg = "NONE" },

  NoiceCmdlineIcon = { fg = colors.nebula10, bg = colors.term_background },
  NoiceCmdlineIconSearch = { fg = colors.baby_pink, bg = colors.term_background },
  NoiceCmdlinePopupBorder = { fg = colors.nebula11, bg = colors.term_background },
  NoiceCmdlinePopupBorderSearch = { fg = colors.baby_pink, bg = colors.term_background },
  NoiceCmdlinePopupTitle = { fg = colors.nebula11, bg = colors.term_background },

  NvimTreeCursorLine = { link = "CursorLine" },
  NvimTreeFolderIcon = { fg = colors.nebula11 },
  NvimTreeFolderName = { fg = colors.nebula11 },
  NvimTreeFolderNew = { fg = colors.nebula11 },
  NvimTreeGitNew = { fg = colors.yellow },
  NvimTreeGitMerge = { fg = colors.yellow },
  NvimTreeGitDirty = { fg = colors.yellow },
  NvimTreeGitDeleted = { fg = colors.red },
  NvimTreeIndentMarker = { fg = colors.dark_purple },
  NvimTreeNormal = { fg = colors.purple, bg = colors.term_background },
  NvimTreeNormalNC = { link = "NvimTreeNormal" },
  NvimTreeOpenedFolderName = { fg = colors.nebula11, bold = true },

  TelescopeBorder = { fg = colors.nebula11 },

  WhichKeyFloat = { fg = colors.light_grey, bg = colors.term_background },
  WhichKeySeparator = { fg = colors.red, bg = colors.term_background },
  WhichKeyValue = { fg = colors.light_grey },
}

require("apika.theme.utils").set_highlights(highlights)
