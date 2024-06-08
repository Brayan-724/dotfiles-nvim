return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function() end,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = require("apika.config.treesitter").opts,
    config = function(_, opts)
      require("apika.config.treesitter").config()
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    dir = "~/Downloads/nvim-treesitter-context/",
    event = "BufEnter",
    opts = { mode = "cursor" },

    dependencies = {
      "nvim-treesitter/nvim-treesitter",
    },
  },

  "IndianBoy42/tree-sitter-just",
  lazy = false,
  config = function()
    require("tree-sitter-just").setup {}
  end,
}
