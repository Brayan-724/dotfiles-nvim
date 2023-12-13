return {
  {
    "nvim-treesitter/nvim-treesitter",
    init = function() end,
    cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
    build = ":TSUpdate",
    opts = require("apika.config.treesitter").opts,
    config = function(_, opts)
      require("nvim-treesitter.configs").setup(opts)
    end,
  },

  {
    "nvim-treesitter/nvim-treesitter-context",
    event = "BufEnter",
    opts = { mode = "topline" },

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
