------- DEFINITION -------
return {
  "nvim-tree/nvim-web-devicons",
  opts = require("apika.config.devicons").opts,
  config = function(_, opts)
    require("nvim-web-devicons").setup(opts)
  end,
}
