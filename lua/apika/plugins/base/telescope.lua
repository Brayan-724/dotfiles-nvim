return {
  "nvim-telescope/telescope.nvim",
  dependencies = {
    "nvim-treesitter/nvim-treesitter",
    { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },

    "jvgrootveld/telescope-zoxide",
  },
  cmd = "Telescope",
  init = function()
    require "apika.lsp".keymap(require("apika.config.telescope"))
  end,
  opts = require("apika.config.telescope").opts,
  config = function(_, opts)
    local telescope = require "telescope"
    telescope.setup(opts)

    -- load extensions
    for _, ext in ipairs(opts.extensions_list) do
      telescope.load_extension(ext)
    end
  end,
}
