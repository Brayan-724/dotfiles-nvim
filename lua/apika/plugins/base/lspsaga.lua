return {
  "nvimdev/lspsaga.nvim",
  config = function()
    require("lspsaga").setup {
      symbol_in_winbar = {
        enable = true,
        hide_keyword = true,
        show_file = false,
        folder_level = 0,
      },
      outline ={
        layout = 'float'
      },
      lightbulb = {
        enable = false,
      },
      implement = {
        enable = true,
        sign = false,
        lang = { "lua" },
        virtual_text = true,
        priority = 100,
      },
    }

    require "apika.theme.lspsaga"
  end,
  dependencies = {
    "nvim-treesitter/nvim-treesitter", -- optional
    "nvim-tree/nvim-web-devicons", -- optional
  },
}
