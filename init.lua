local ignite_path = vim.fn.stdpath "config" .. "/ignite"

for _, file in pairs(vim.fn.readdir(ignite_path)) do

  local absolute_path = ignite_path .. "/" .. file
  vim.cmd.luafile(absolute_path)
end

require "apika.config.mappings"()
-- require "apika.theme.custom"
