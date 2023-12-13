local colors = require "apika.theme.colors"

local highlights = {
  TblineFill = {
    fg = colors.space0,
    bg = colors.space0,
  },

  TbLineBufOn = {
    fg = colors.space0,
    bg = colors.purple,
  },

  TbLineBufOnSep = {
    bg = colors.space0,
    fg = colors.purple,
  },

  TbLineBufOnModified = {
    fg = colors.space0,
    bg = colors.red,
  },

  TbLineBufOnSepModified = {
    fg = colors.red,
    bg = colors.space0,
  },

  TbLineBufOff = {
    fg = colors.light_grey,
    bg = colors.space0,
  },

  TbLineBufOffModified = {
    fg = colors.red,
    bg = colors.space0,
  },

  TbLineBufOffSepModified = {
    fg = colors.space0,
    bg = colors.space0,
  },

  TbLineTabOn = {
    fg = colors.nebula11,
    bg = colors.space0,
    bold = true,
  },

  TbLineTabOff = {
    fg = colors.nebula10,
    bg = colors.space0,
  },
}

require "apika.theme.utils".set_highlights(highlights)
