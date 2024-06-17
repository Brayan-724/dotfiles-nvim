local lazypath = vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
local repo = "https://github.com/folke/lazy.nvim.git"

if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.cmd "redraw"
  vim.api.nvim_echo({ { "  Installing lazy.nvim & plugins ...", "Bold" } }, true, {})

  local output = vim.fn.system { "git", "clone", "--depth=1", "--filter=blob:none", "--branch=stable", repo, lazypath }
  assert(vim.v.shell_error == 0, "External call failed with error code: " .. vim.v.shell_error .. "\n" .. output)

end

vim.opt.rtp:prepend(lazypath)
