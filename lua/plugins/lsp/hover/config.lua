return {
  after_config = function()
    vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
  end,
}
