-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

local colors = {
  space0 = "#100e23",
}

local term_background = colors.space0
---@type Base46HLGroupsList
M.override = {
  IndentBlanklineChar = { fg = "light_grey" },

  NvDashAscii = { fg = "purple", bg = term_background },
  NvDashButtons = { fg = "nord_blue", bg = term_background },
}

---@type HLTable
M.add = {
  FidgetTask = { bg = term_background },
  FidgetTitle = { bg = term_background },

  TreesitterContext = { bg = term_background },
  TreesitterContextBottom = { bg = term_background, underline = true },
}

return M
