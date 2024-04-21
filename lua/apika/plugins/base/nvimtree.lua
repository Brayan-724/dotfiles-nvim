return {
  "nvim-tree/nvim-tree.lua",
  apika_config = "nvimtree",
  cmd = { "NvimTreeToggle", "NvimTreeFocus" },
  opts = require("apika.utils").opts_config,
  init = require("apika.utils").keymap_config,
  config = require("apika.utils").theme_config(function (_, opts)
    require("nvim-tree").setup(opts)
  end),
}
