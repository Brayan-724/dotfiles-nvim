local M = {}

function M.init_lazy()
  local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"

  if not vim.uv.fs_stat(lazypath) then
    local utils = require "apika.utils"

    --------- lazy.nvim ---------------
    utils.echo "  Installing lazy.nvim & plugins ..."
    local repo = "https://github.com/folke/lazy.nvim.git"
    utils.shell_call { "git", "clone", "--filter=blob:none", "--branch=stable", repo, lazypath }
    vim.opt.rtp:prepend(lazypath)
  end

  vim.opt.rtp:prepend(lazypath)

  require "apika.plugins".setup()
end

function M.init_statusline()
  vim.opt.statusline = "%!v:lua.require('apika.statusline').run()"
end

function M.init_mappings()
  require("apika.config.mappings")()
end

function M.ignite()
  require "apika.init"
  M.init_lazy()

  M.init_statusline()
  require "apika.tabline"

  M.init_mappings()

  require "apika.theme.custom"

end

return M
