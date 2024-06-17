return {
  before_config = function(_, opts)
    vim.g.nvimtree_side = opts.view.side
  end
}
