local opt = vim.opt
local g = vim.g

------------------------------------- clipboard -----------------------------------------
g.clipboard = {
  name = "WslClipboard",
  copy = {
    ["+"] = "clip.exe",
    ["*"] = "clip.exe",
  },
  paste = {
    ["+"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
    ["*"] = 'powershell.exe -c [Console]::Out.Write($(Get-Clipboard -Raw).tostring().replace("`r", ""))',
  },
  cache_enabled = 0,
}

-------------------------------------- options ------------------------------------------
opt.laststatus = 3 -- global statusline
opt.showmode = false

-- g.clipboard = "WslClipboard"
-- opt.clipboard = "unnamedplus"
opt.cursorline = true

-- Indenting
opt.expandtab = true
opt.shiftwidth = 2
opt.smartindent = true
opt.tabstop = 2
opt.softtabstop = 2

opt.fillchars = { eob = " " }
opt.ignorecase = true
opt.smartcase = true
opt.mouse = "a"

-- Numbers
opt.number = true
opt.numberwidth = 2
opt.ruler = false

-- disable nvim intro
opt.shortmess:append "sI"

opt.signcolumn = "yes"
opt.splitbelow = true
opt.splitright = true
opt.termguicolors = true
opt.timeoutlen = 400
opt.undofile = true

-- interval for writing swap file to disk, also used by gitsigns
opt.updatetime = 250

-- go to previous/next line with h,l,left arrow and right arrow
-- when cursor reaches end/beginning of line
opt.whichwrap:append "<>[]hl"

g.mapleader = " "

-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

-- add binaries installed by mason.nvim to path
local is_windows = vim.uv.os_uname().sysname == "Windows_NT"
vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

vim.filetype.add {
  extension = {
    astro = "astro",
    mdx = "astro",
  },
}

-------------------------------------- autocmds ------------------------------------------
local autocmd = vim.api.nvim_create_autocmd

-- dont list quickfix buffers
autocmd("FileType", {
  pattern = "qf",
  callback = function()
    vim.opt_local.buflisted = false
  end,
})

-- Copy to system
-- local uv = vim.uv

-- vim.g.clipboard = "unnamedplus"
--
-- if vim.fn.has "wsl" == 1 then
--   autocmd("TextYankPost", {
--     group = vim.api.nvim_create_augroup("Yank", { clear = true }),
--     callback = function()
--       local stdin = uv.new_pipe()
--       local stdout = uv.new_pipe()
--       local stderr = uv.new_pipe()
--
--       local handle = uv.spawn("clip.exe", { stdio = { stdin, stdout, stderr } })
--
--       uv.write(stdin, vim.fn.getreg '"')
--       uv.shutdown(stdin, function()
--         vim.defer_fn(function()
--           handle:kill(9)
--         end, 2000)
--       end)
--     end,
--   })
-- end

-------------------------------------- commands ------------------------------------------
local new_cmd = vim.api.nvim_create_user_command

new_cmd("ReloadConfig", function()
  local reload = require("plenary.reload").reload_module
  reload "apika.ignite"
  reload "apika.plugins"
  -- reload

  -- config = require("core.utils").load_config()

  -- vim.g.nvchad_theme = config.ui.theme
  -- vim.g.transparency = config.ui.transparency

  -- statusline
  -- require("plenary.reload").reload_module("nvchad.statusline." .. config.ui.statusline.theme)
  -- vim.opt.statusline = "%!v:lua.require('nvchad.statusline." .. config.ui.statusline.theme .. "').run()"

  -- tabufline
  -- if config.ui.tabufline.enabled then
  --   require("plenary.reload").reload_module "nvchad.tabufline.modules"
  --   vim.opt.tabline = "%!v:lua.require('nvchad.tabufline.modules').run()"
  -- end

  -- require("base46").load_all_highlights()
  vim.cmd "redraw!"
end, {})
