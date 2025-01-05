return {
  "nvim-treesitter/nvim-treesitter",
  event = "BufEnter",
  cmd = { "TSInstall", "TSBufEnable", "TSBufDisable", "TSModuleInfo" },
  build = ":TSUpdate",

  dependencies = {
    { "nushell/tree-sitter-nu", build = ":TSUpdate nu" },
  }
}
