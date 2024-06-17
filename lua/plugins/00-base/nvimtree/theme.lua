local colors = require "apika.theme.colors"

return {
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
}
