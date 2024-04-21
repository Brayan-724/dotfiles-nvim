local function split(inputstr)
  local sep = "\n"
  local t = {}
  for str in string.gmatch(inputstr, "([^" .. sep .. "]+)") do
    table.insert(t, str)
  end
  return t
end

return {
  "nvimdev/dashboard-nvim",
  event = "VimEnter",
  config = function()
    require("dashboard").setup {
      shortcut_type = "number",
      hide = { tabline = true },
      config = {
        header = split [[

            ,ggg, ,ggggggggggg,   ,a8a,  ,ggg,        gg            ,ggg,  
          dP""8IdP"""88""""""Y8,,8" "8,dP""Y8b       dP           dP""8I  
         dP   88Yb,  88      `8bd8   8bYb, `88      d8'          dP   88  
        dP    88 `"  88      ,8P88   88 `"  88    ,dP'          dP    88  
       ,8'    88     88aaaad8P" 88   88     88aaad8"           ,8'    88  
       d88888888     88"""""    Y8   8P     88""""Yb,          d88888888  
 __   ,8"     88     88         `8, ,8'     88     "8b   __   ,8"     88  
dP"  ,8P      Y8     88    8888  "8,8"      88      `8i dP"  ,8P      Y8  
Yb,_,dP       `8b,   88    `8b,  ,d8b,      88       Yb,Yb,_,dP       `8b,
 "Y8P"         `Y8   88      "Y88P" "Y8     88        Y8 "Y8P"         `Y8
          ]],
      },
    }
  end,
  dependencies = { { "nvim-tree/nvim-web-devicons" } },
}
