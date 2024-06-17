return {
  after_config = function()
    -- Setup keymaps
    vim.keymap.set("n", "K", require("hover").hover, { desc = "hover.nvim" })
    vim.keymap.set("n", "gK", require("hover").hover_select, { desc = "hover.nvim (select)" })
    vim.keymap.set("n", "<C-p>", function()
      require("hover").hover_switch "previous"
    end, { desc = "hover.nvim (previous source)" })
  end,
}
