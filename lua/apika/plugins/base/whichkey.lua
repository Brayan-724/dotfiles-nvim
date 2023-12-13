return {
  "folke/which-key.nvim",
  keys = { "<leader>", "<c-r>", "<c-w>", '"', "'", "`", "c", "v", "g" },
  cmd = "WhichKey",
  opts = {
    window = {
      border = "single",
      padding = { 0, 0, 0, 0 }
    }
  },
  config = function(_, opts)
    require("which-key").setup(opts)
  end,
}
