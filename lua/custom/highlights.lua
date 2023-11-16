-- To find any highlight groups: "<cmd> Telescope highlights"
-- Each highlight group can take a table with variables fg, bg, bold, italic, etc
-- base30 variable names can also be used as colors

local M = {}

local colors = {
  space0 = "#100e23",
  space1 = "#1e1c31",
  space2 = "#2d2b40",
  space3 = "#3e3859",
  space4 = "#585273",
  astral1 = "#cbe3e7",
  cyan = "#aaffe4",
  darkcyan = "#63f2f1",
  yellow = "#ffe9aa",
  darkyellow = "#ffb378",
  red = "#f48fb1",
  darkred = "#ff5458",
  green = "#a1efd3",
  darkgreen = "#62d196",
  purple = "#d4bfff",
  nebula10 = "#78A8ff",
  nebula11 = "#7676ff",
}

local term_background = colors.space0
---@type Base46HLGroupsList
M.override = {
  Comment = { fg = "nord_blue", bold = true },
  Constant = { fg = "dark_purple" },
  Conditional = { fg = "green" },
  Define = { fg = colors.nebula11 },
  Identifier = { fg = colors.red },
  Keyword = { fg = colors.nebula11 },
  Normal = { bg = term_background },
  NormalFloat = { bg = "black2" },
  Macro = { fg = "dark_purple" },
  PreProc = { fg = "purple" },
  Repeat = { link = "Keyword" },
  Structure = { fg = "purple" },
  Type = { fg = colors.darkred },
  Typedef = { fg = colors.purple },
  Variable = { link = "Identifier" },

  ["@field"] = { fg = colors.astral1 },
  ["@parameter"] = { link = "Variable" },
  ["@string"] = { fg = colors.darkgreen },
  ["@type.definition"] = { link = "Keyword" },
  ["@variable"] = { link = "Variable" },

  CursorLine = { underline = true, bold = true },
  CursorLineNr = { bg = term_background, fg = colors.red, bold = true, underline = true },
  LineNr = { bg = term_background, fg = "#eeeeee", bold = true },
  SignColumn = { bg = term_background, fg = "white" },
  WinSeparator = { fg = colors.nebula11 },

  Folded = { fg = "yellow" },
  FoldColumn = { bg = "NONE" },

  IndentBlanklineChar = { fg = "light_grey" },

  NvDashAscii = { fg = "purple", bg = term_background },
  NvDashButtons = { fg = "nord_blue", bg = term_background },

  NvimTreeCursorLine = { link = "CursorLine" },
  NvimTreeFolderIcon = { fg = colors.nebula11 },
  NvimTreeFolderName = { fg = colors.nebula11 },
  NvimTreeGitNew = { link = "NvimTreeNormal" },
  NvimTreeGitDeleted = { fg = "red" },
  NvimTreeIndentMarker = { fg = "dark_purple" },
  NvimTreeNormal = { fg = colors.purple, bg = term_background },
  NvimTreeNormalNC = { link = "NvimTreeNormal" },
  NvimTreeOpenedFolderName = { fg = colors.nebula11, bold = true },

  StatusLine = { bg = term_background },
  St_sep_r = { fg = "black", bg = term_background },

  St_CommandModeText = { bg = "black" },
  St_ConfirmModeText = { bg = "black" },
  St_InsertModeText = { bg = "black" },
  St_NormalModeText = { bg = "black" },
  St_NterminalModeText = { bg = "black" },
  St_ReplaceModeText = { bg = "black" },
  St_SelectModeText = { bg = "black" },
  St_TerminalModeText = { bg = "black" },
  St_VisualModeText = { bg = "black" },

  St_CommandModeSep = { bg = term_background },
  St_ConfirmModeSep = { bg = term_background },
  St_InsertModeSep = { bg = term_background },
  St_NormalModeSep = { bg = term_background },
  St_NTerminalModeSep = { bg = term_background },
  St_ReplaceModeSep = { bg = term_background },
  St_SelectModeSep = { bg = term_background },
  St_TerminalModeSep = { bg = term_background },
  St_VisualModeSep = { bg = term_background },

  St_file_txt = { bg = "black" },
  St_file_sep = { bg = term_background },
  St_gitIcons = { bg = term_background },
  St_lspWarning = { bg = term_background },
  St_lsp_txt = { bg = "black" },
  St_lsp_sep = { bg = term_background },
  St_cwd_txt = { bg = "black" },
  St_cwd_sep = { bg = term_background },
  St_Pos_txt = { bg = "black" },
  St_Pos_sep = { bg = term_background },

  TblineFill = { bg = term_background },

  TelescopeBorder = { bg = "NONE", fg = "black2" },
  TelescopeNormal = { bg = "black2" },
  TelescopePromptBorder = { link = "TelescopeBorder" },
  TelescopePromptNormal = { link = "TelescopeNormal" },
  TelescopeSelection = { bg = "grey" },
}

---@type HLTable
M.add = {
  FidgetTask = { bg = term_background },
  FidgetTitle = { bg = term_background },

  St_CommandModeText = { bg = "black" },
  St_ConfirmModeText = { bg = "black" },
  St_InsertModeText = { bg = "black" },
  St_NormalModeText = { bg = "black" },
  St_NterminalModeText = { bg = "black" },
  St_ReplaceModeText = { bg = "black" },
  St_SelectModeText = { bg = "black" },
  St_TerminalModeText = { bg = "black" },
  St_VisualModeText = { bg = "black" },

  TreesitterContext = { bg = term_background },
  TreesitterContextBottom = { bg = term_background, underline = true },
}

return M
