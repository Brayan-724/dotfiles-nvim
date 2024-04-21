vim.g.colors_name = "apika"

local colors = require "apika.theme.colors"

local palette = {
  base00 = colors.space0,
  base01 = "#1a1d21",
  base02 = "#23262a",
  base03 = "#2b2e32",
  base04 = "#323539",
  base05 = "#c5c5c6",
  base06 = "#cbcbcc",
  base07 = "#d4d4d5",
  base08 = "#37d99e",
  base09 = "#f0a988",
  base0A = "#e5d487",
  base0B = "#e87979",
  base0C = "#37d99e",
  base0D = "#5fb0fc",
  base0E = "#c397d8",
  base0F = "#e87979",
}

require("mini.base16").setup { palette = vim.tbl_deep_extend("force", palette, colors) }
