vim.g.colors_name = "apika"

local colors = require "apika.theme.colors"

local palette = {
  base00 = colors.space0,
  -- base00 = "#101317",
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

  -- base00 = colors.space0,
  -- base01 = "#353b45",
  -- base02 = "#3e4451",
  -- base03 = "#545862",
  -- base04 = "#565c64",
  -- base05 = "#abb2bf",
  -- base06 = "#b6bdca",
  -- base07 = "#c8ccd4",
  -- base08 = "#e06c75",
  -- base09 = "#d19a66",
  -- base0A = "#e5c07b",
  -- base0B = "#98c379",
  -- base0C = "#56b6c2",
  -- base0D = "#61afef",
  -- base0E = "#c678dd",
  -- base0F = "#be5046",
}

require("mini.base16").setup { palette = vim.tbl_deep_extend("force", palette, colors) }
