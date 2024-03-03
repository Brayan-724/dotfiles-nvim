return {
  "mg979/vim-visual-multi",
  lazy = false,
  init = function ()
    vim.g.VM_maps = {
      ["Find Under"] = '<Leader>cC',
      ["Find Subword Under"] = '<Leader>cC'
    }
  end
}
