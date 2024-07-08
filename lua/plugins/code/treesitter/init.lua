return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufEnter",
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",
}
