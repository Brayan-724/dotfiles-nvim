local colors = require "apika.theme.colors"

return {
  Comment = { fg = colors.nord_blue, bold = true },
  Constant = { fg = colors.dark_purple },
  Conditional = { fg = colors.green },
  Define = { fg = colors.nebula11 },
  FloatBorder = { fg = colors.baby_pink, bg = colors.float_background },
  Identifier = { fg = colors.red },
  Keyword = { fg = colors.nebula11 },
  Normal = { bg = colors.term_background },
  NormalFloat = { bg = colors.float_background },
  Macro = { fg = colors.dark_purple },
  PreProc = { fg = colors.purple },
  Repeat = { link = "Keyword" },
  Structure = { fg = colors.purple },
  Type = { fg = colors.darkred },
  Typedef = { fg = colors.purple },
  Variable = { link = "Identifier" },

  ["@builtin"] = { fg = colors.purple },
  ["@field"] = { fg = colors.astral1 },
  ["@parameter"] = { link = "Variable" },
  ["@string"] = { fg = colors.darkgreen },
  ["@variable"] = { link = "Variable" },


  ["@lsp.mod.static"] = { link = "Constant" },
  ["@lsp.type.attributeBracket"] = { link = "Special" },
  ["@lsp.type.const"] = { link = "Constant" },
  ["@lsp.type.modifier"] = { link = "Keyword" },
  ["@lsp.type.typeParameter.java"] = { link = "Structure" },
  ["@lsp.type.variable"] = { link = "Variable" },
  ["@tag.builtin"] = { link="Special" },
  ["@type.builtin"] = { link = "@builtin" },
  ["@type.definition"] = { link = "Keyword" },

  ColorColumn = { bg = colors.term_background, fg = colors.white },
  CursorColumn = { link = "ColorColumn" },
  CursorLine = { bg = colors.space1, bold = true },
  CursorLineFold = { bg = colors.term_background, fg = colors.red },
  CursorLineNr = { bg = colors.term_background, fg = colors.red, bold = true },
  CursorLineSign = { bg = colors.term_background, fg = colors.red },

  LineNr = { bg = colors.term_background, fg = "#eeeeee", bold = true },
  LineNrAbove = { bg = colors.term_background, fg = "#eeeeee", bold = true },
  LineNrBelow = { bg = colors.term_background, fg = "#eeeeee", bold = true },
  LspInfoBorder = { link = "FloatBorder" },
  SignColumn = { link = "ColorColumn" },
  WinSeparator = { fg = colors.nebula11 },

  Folded = { fg = colors.yellow },
  FoldColumn = { bg = "NONE" },

  NoiceCmdlineIcon = { fg = colors.nebula10, bg = colors.term_background },
  NoiceCmdlineIconSearch = { fg = colors.baby_pink, bg = colors.term_background },
  NoiceCmdlinePopupBorder = { fg = colors.baby_pink, bg = colors.term_background },
  NoiceCmdlinePopupBorderSearch = { fg = colors.baby_pink, bg = colors.term_background },
  NoiceCmdlinePopupTitle = { fg = colors.nebula11, bg = colors.term_background },

  TelescopeNormal = { bg = colors.float_background },
  TelescopeBorder = { fg = colors.baby_pink, bg = colors.float_background },

  WhichKeyFloat = { fg = colors.light_grey, bg = colors.float_background },
  WhichKeySeparator = { fg = colors.red, bg = colors.float_background },
  WhichKeyValue = { fg = colors.light_grey },

  DiffAdd = { fg = colors.red, bg = colors.term_background },
}
