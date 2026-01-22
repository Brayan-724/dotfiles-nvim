local function split(inputstr)
  local sep = "\n"
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

return {
  shortcut_type = "number",
  hide = { tabline = true },
  config = {
    shortcut = {
      { desc = "Dotfiles", key = 'do', action = '!xdg-open https://github.com/Brayan-724/dotfiles-nvim' },
      { desc = "Load session", key = 'TODO', action = 'echo "TODO"' },
    },
    header = split [[
            ,ggggggggg,    ,a8a,  ,ggg,        gg          ,ggg,
          dP""8I""""""Y8, ,8" "8,dP""Y8b       dP         dP""8I
         dP   88      `8b d8   8bYb, `88      d8'        dP   88
        dP    88      ,8P 88   88 `"  88    ,dP'        dP    88
       ,8'    88aaaad8P"  88   88     88aaad8"         ,8'    88
     ,d888888888"""""     Y8   8P     88""""Yb,        d88888888
   ,d ,8"     88          `8, ,8'     88     "8b      ,8"     88
  dP ,8P      Y8           "8,8"      88      `8i    ,8P      Y8
   Yb,dP        `8b, ,d`8b,  ,d8b,      88        Yb,_,dP       `8b,
   "YP"          `Y88P"  "Y88P" "Y8     88         "Y8P"         `Y8
          ]],
    footer = {  "", "Apika's distro" }
  },
}
