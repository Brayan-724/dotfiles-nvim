local M = {}

function M.ignite()
  local ignite_path = vim.fn.stdpath("config") .. "/ignite"
  local ignite_dir = vim.uv.fs_scandir(ignite_path)

  while true do
    local file = vim.uv.fs_scandir_next(ignite_dir)
    if file == nil then
      break
    end

    local absolute_path = ignite_path .. "/" .. file
    vim.cmd.luafile(absolute_path)
  end
end

return M
