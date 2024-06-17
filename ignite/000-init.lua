-- disable some default providers
for _, provider in ipairs { "node", "perl", "python3", "ruby" } do
  vim.g["loaded_" .. provider .. "_provider"] = 0
end

vim.g.markdown_fenced_languages = {
  "ts=typescript",
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


-------------------------------------- commands ------------------------------------------
local new_cmd = vim.api.nvim_create_user_command

new_cmd("ReloadConfig", function()
  local reload = require("plenary.reload").reload_module
  reload "apika.ignite"
  reload "apika.plugins"

  vim.cmd "redraw!"
end, {})
