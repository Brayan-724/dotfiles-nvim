local M = {}

function M.init_lazy()
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

  if not vim.loop.fs_stat(lazypath) then
    local utils = require "apika.utils"

    --------- lazy.nvim ---------------
    utils.echo "  Installing lazy.nvim & plugins ..."
    local repo = "https://github.com/folke/lazy.nvim.git"
    utils.shell_call { "git", "clone", "--depth=1", "--filter=blob:none", "--branch=stable", repo, lazypath }
    vim.opt.rtp:prepend(lazypath)
  end

  vim.opt.rtp:prepend(lazypath)

  require "apika.plugins".setup()
end

function M.ignite()
  require "apika.init"
  M.init_lazy()
  require "apika.neovide"

  vim.opt.statusline = "%!v:lua.require('apika.statusline').run()"
  require "apika.tabline"

  require("apika.config.mappings")()

  require "apika.theme.custom"

end

return M
