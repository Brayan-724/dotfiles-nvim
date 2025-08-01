local hl_name = "FloatBorder"
local border = {
  { "╭", hl_name },
  { "─", hl_name },
  { "╮", hl_name },
  { "│", hl_name },
  { "╯", hl_name },
  { "─", hl_name },
  { "╰", hl_name },
  { "│", hl_name },
}

return {
  signs = {
    add = { text = "│" },
    change = { text = "│" },
    delete = { text = "󰍵" },
    topdelete = { text = "‾" },
    changedelete = { text = "~" },
    untracked = { text = "│" },
  },
  preview_config = {
    border = border
  },
}
