return {
  "nvim-treesitter/nvim-treesitter",
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
  opts = require("apika.config.treesitter").opts,
  config = function(_, opts)
    require("apika.config.treesitter").config()
    require("nvim-treesitter.configs").setup(opts)
  end,
}
