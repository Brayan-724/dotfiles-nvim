-- Path to overriding theme and highlights files
local highlights = require "custom.highlights"

vim.g.toggle_theme_icon = ""

local ui = {
  theme = "radium",
  theme_toggle = { "radium" },

  hl_override = highlights.override,
  hl_add = highlights.add,

  ---@type NvCmpConfig
  cmp = {
    style = "flat_light",
    icons = true,
    lspkind_text = false,
    border_color = "red",
    selected_item_bg = "colored",
  },

  ---@type NvDashboardConfig
  nvdash = {
    load_on_startup = true,

    header = {
      "            ,ggg, ,ggggggggggg,   ,a8a,  ,ggg,        gg            ,ggg,  ",
      '          dP""8IdP"""88""""""Y8,,8" "8,dP""Y8b       dP           dP""8I  ',
      "         dP   88Yb,  88      `8bd8   8bYb, `88      d8'          dP   88  ",
      '        dP    88 `"  88      ,8P88   88 `"  88    ,dP\'          dP    88  ',
      "       ,8'    88     88aaaad8P\" 88   88     88aaad8\"           ,8'    88  ",
      '       d88888888     88"""""    Y8   8P     88""""Yb,          d88888888  ',
      ' __   ,8"     88     88         `8, ,8\'     88     "8b   __   ,8"     88  ',
      'dP"  ,8P      Y8     88    8888  "8,8"      88      `8i dP"  ,8P      Y8  ',
      "Yb,_,dP       `8b,   88    `8b,  ,d8b,      88       Yb,Yb,_,dP       `8b,",
      ' "Y8P"         `Y8   88      "Y88P" "Y8     88        Y8 "Y8P"         `Y8',
    },

    buttons = {
      { "  Find File", "Spc f f", "Telescope find_files" },
      { "󰈙  Recent Files", "Spc f o", "Telescope oldfiles" },
      { "󰈭  Find Word", "Spc f w", "Telescope live_grep" },
      { "  Bookmarks", "Spc b m", "Telescope marks" },
      { "  Themes", "Spc t h", "Telescope themes" },
      { "  Mappings", "Spc c h", "NvCheatsheet" },
    },
  },

  ---@type NvTabLineConfig
  tabufline = {
    enabled = true,
    lazyload = false,
    show_numbers = false,
  },

  ---@type NvTelescopeConfig
  telescope = {
    style = "borderless",
  },

  lsp = {},

  ---@type NvCheatsheetConfig
  cheatsheet = {
    theme = "grid",
  },

  ---@type NvStatusLineConfig
  statusline = {
    theme = "minimal",
    lspprogress_len = 0,
    separator_style = "round",
  },

  ---@type ExtendedModules[]
  extended_integrations = { "dap", "notify" },
}

---@type ChadrcConfig
local M = {
  ui = ui,
  lazy_nvim = {},

  plugins = "custom.plugins",

  -- check core.mappings for table structure
  mappings = require "custom.mappings",
}

return M
