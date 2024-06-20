return {
  definition = {
    keys = {
      close = "q",
      edit = "<C-i>o",
      quit = "<C-i>q",
      split = "<C-i>h",
      tabe = "<C-i>t",
      vsplit = "<C-i>v",
    },
  },
  symbol_in_winbar = {
    enable = true,
    hide_keyword = true,
    show_file = false,
    folder_level = 0,
  },
  outline = {
    layout = "float",
  },
  lightbulb = {
    enable = false,
    sign = false,
    virtual_text = false,
    enable_in_insert = false,
  },
  implement = {
    enable = true,
    sign = false,
    lang = { "lua" },
    virtual_text = true,
    priority = 100,
  },
}
