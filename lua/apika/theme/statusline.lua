local colors = require "apika.theme.colors"

-- change color values according to statusilne themes
local statusline_theme = "minimal"

-- default values from the colors palette
local light_grey

local M = {}

M.minimal = {
  StatusLine = {
    bg = colors.space0,
  },

  St_gitIcons = {
    fg = light_grey,
    bg = "none",
    bold = true,
  },

  -- LSP
  St_lspError = {
    fg = colors.red,
    bg = "none",
  },

  St_lspWarning = {
    fg = colors.yellow,
    bg = "none",
  },

  St_LspHints = {
    fg = colors.purple,
    bg = "none",
  },

  St_LspInfo = {
    fg = colors.green,
    bg = "none",
  },

  St_LspProgress = {
    fg = colors.green,
    bg = "none",
  },

  St_LspStatus_Icon = {
    fg = colors.black,
    bg = colors.nord_blue,
  },

  St_EmptySpace = {
    fg = colors.space0,
    bg = colors.space0,
  },

  St_EmptySpace2 = {
    fg = colors.space0,
    bg = colors.space0,
  },

  St_file_info = {
    fg = colors.white,
    bg = "none",
  },

  St_file_sep = {
    fg = colors.space0,
    bg = "none",
  },

  St_sep_r = {
    fg = colors.black,
    bg = colors.space0,
  },
}

local function genModes_hl(modename, col)
  M.minimal["St_" .. modename .. "Mode"] = { fg = colors.black, bg = colors[col], bold = true }
  M.minimal["St_" .. modename .. "ModeSep"] = { fg = colors[col], bg = colors.space0, bold = true }
  M.minimal["St_" .. modename .. "modeText"] = { fg = colors[col], bg = colors.black, bold = true }
end

-- add mode highlights
if statusline_theme == "default" then
  genModes_hl("Normal", "nord_blue")
else
  genModes_hl("Normal", "blue")
end

genModes_hl("Visual", "cyan")
genModes_hl("Insert", "dark_purple")
genModes_hl("Terminal", "green")
genModes_hl("NTerminal", "yellow")
genModes_hl("Replace", "orange")
genModes_hl("Confirm", "teal")
genModes_hl("Command", "green")
genModes_hl("Select", "blue")

-- add block highlights for minimal theme
local function gen_hl(name, col)
  M.minimal["St_" .. name .. "_bg"] = {
    fg = colors.space0,
    bg = colors[col],
  }

  M.minimal["St_" .. name .. "_txt"] = {
    fg = colors[col],
    bg = colors.black,
  }

  M.minimal["St_" .. name .. "_sep"] = {
    fg = colors[col],
    bg = colors.space0,
  }
end

gen_hl("file", "red")
gen_hl("Pos", "yellow")
gen_hl("cwd", "orange")
gen_hl("lsp", "green")

for k, v in pairs(M.minimal) do
  vim.api.nvim_set_hl(0, k, v)
end

