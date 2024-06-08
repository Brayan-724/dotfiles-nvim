return {
  { "folke/neodev.nvim", opts = {
    library = { plugins = { "nvim-dap-ui" }, types = true },
  } },
  {
    "mfussenegger/nvim-dap",
    apika_config = "dap",
    opts = require("apika.utils").opts_config,
    config = require("apika.config.dap").config,
  },
  { "rcarriga/nvim-dap-ui", dependencies = { "mfussenegger/nvim-dap", "nvim-neotest/nvim-nio" }, config = true },
  { "theHamsta/nvim-dap-virtual-text", lazy = false, config = true },

  {
    "LiadOz/nvim-dap-repl-highlights",
    lazy = false,
    config = true,
  },
}
