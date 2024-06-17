return {
  "nvim-telescope/telescope.nvim",
  name = "telescope",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

    "jvgrootveld/telescope-zoxide",
  },
  lazy = false,
  config = function(_, opts)
    local telescope = require "telescope"
    telescope.setup(opts)

    -- load extensions
    for _, ext in ipairs(opts.extensions_list) do
      telescope.load_extension(ext)
    end
  end,
}
