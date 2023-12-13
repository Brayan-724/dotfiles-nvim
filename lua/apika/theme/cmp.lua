local colors = require "apika.theme.colors"

local highlights = {
  CmpBorder = { fg = colors.nebula11, bg = colors.term_background },
  CmpDoc = { bg = colors.term_background },
  CmpDocBorder = { fg = colors.nebula11, bg = colors.term_background },
  CmpItemAbbr = { fg = colors.white },
  CmpItemAbbrMatch = { fg = colors.blue, bold = true },
  CmpPmenu = {
    bg = colors.term_background,
  },
  CmpSel = { link = "PmenuSel", bold = true },
}

-- cmp item kinds
local item_kinds = {
  CmpItemKindConstant = { fg = colors.base09 },
  CmpItemKindFunction = { fg = colors.base0D },
  CmpItemKindIdentifier = { fg = colors.base08 },
  CmpItemKindField = { fg = colors.base08 },
  CmpItemKindVariable = { fg = colors.base0E },
  CmpItemKindSnippet = { fg = colors.red },
  CmpItemKindText = { fg = colors.base0B },
  CmpItemKindStructure = { fg = colors.base0E },
  CmpItemKindType = { fg = colors.base0A },
  CmpItemKindKeyword = { fg = colors.base07 },
  CmpItemKindMethod = { fg = colors.base0D },
  CmpItemKindConstructor = { fg = colors.blue },
  CmpItemKindFolder = { fg = colors.base07 },
  CmpItemKindModule = { fg = colors.base0A },
  CmpItemKindProperty = { fg = colors.base08 },
  CmpItemKindEnum = { fg = colors.blue },
  CmpItemKindUnit = { fg = colors.base0E },
  CmpItemKindClass = { fg = colors.teal },
  CmpItemKindFile = { fg = colors.base07 },
  CmpItemKindInterface = { fg = colors.green },
  CmpItemKindColor = { fg = colors.white },
  CmpItemKindReference = { fg = colors.base05 },
  CmpItemKindEnumMember = { fg = colors.purple },
  CmpItemKindStruct = { fg = colors.base0E },
  CmpItemKindValue = { fg = colors.cyan },
  CmpItemKindEvent = { fg = colors.yellow },
  CmpItemKindOperator = { fg = colors.base05 },
  CmpItemKindTypeParameter = { fg = colors.base08 },
  CmpItemKindCopilot = { fg = colors.green },
  CmpItemKindCodeium = { fg = colors.vibrant_green },
  CmpItemKindTabNine = { fg = colors.baby_pink },
}

highlights = vim.tbl_deep_extend("force", highlights, item_kinds)

require("apika.theme.utils").set_highlights(highlights)
