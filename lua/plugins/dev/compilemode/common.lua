local M = {
  lock_file = vim.fn.stdpath "data" .. "/cmd.lock",
}

function M.load_lock()
  local f = io.open(M.lock_file, "r")
  if not f then
    return
  end

  local data = f:read "a"
  if type(data) == "string" then
    vim.g.compile_command = data
  end
  f:close()
end

function M.save_lock()
  if not vim.g.compile_command then
    return
  end

  local f = io.open(M.lock_file, "w+")
  if not f then
    return
  end

  local _, err = f:write(vim.g.compile_command)
  if err then
    vim.notify(err, vim.log.levels.ERROR)
  end
  f:close()
end

return M
