---@param cmd string[]
---@param cwd string?
local function start_wezterm_tab(cmd, cwd)
  local cmd_table = { "wezterm", "start", "--new-tab" }
  if cwd then
    table.insert(cmd_table, "--cwd")
    table.insert(cmd_table, cwd)
  end

  table.insert(cmd_table, "--")
  for _, arg in pairs(cmd) do
    table.insert(cmd_table, arg)
  end

  vim.notify(vim.inspect(cmd_table), vim.log.levels.TRACE)
  local ret = vim.system(cmd_table):wait()
  vim.notify(vim.inspect(ret), vim.log.levels.TRACE)
end

-- ---@param cmd string[]?
-- ---@param cwd string?
-- ---@return string? pane_id
-- local function spawn_wezterm_tab(cmd, cwd)
--   local cmd_table = { "wezterm", "cli", "spawn" }
--   if cwd then
--     table.insert(cmd_table, "--cwd")
--     table.insert(cmd_table, cwd)
--   end
--
--   local spawn_ret = vim.system(cmd_table):wait()
--   vim.notify(vim.inspect(spawn_ret))
--
--   local spawn_stdout = spawn_ret.stdout or spawn_ret.stderr
--
--   if spawn_ret.code ~= 0 or not spawn_stdout then
--     return
--   end
--
--   local pane = spawn_stdout:sub(1, spawn_stdout:len() - 1)
--
--   if cmd then
--     local cmd_parsed = table.concat(cmd, " ")
--     local ret = vim.system({ "wezterm", "cli", "send-text", "--pane-id", pane, cmd_parsed }):wait()
--     vim.notify(vim.inspect(ret))
--   end
--
--   return pane
-- end

local M = {
  enabled = true,
}

---@param image string
---@param cwd string?
function M.show_image(image, cwd)
  if not cwd then
    local pwd = vim.system({ "pwd" }):wait().stdout

    if pwd then
      cwd = pwd:sub(1, pwd:len() - 1)
    else
      cwd = vim.fn.expand "$HOME"
    end
  end

  vim.notify("Showing " .. image .. " at " .. cwd, vim.log.levels.TRACE)

  start_wezterm_tab(
    { "wezterm", "imgcat", "--position", "0,0", "--width", "100%", "--height", "100%", "--hold", image },
    cwd
  )
end

vim.api.nvim_create_user_command("ImageShow", function(ev)
  --- @type string|nil
  local image = ev.arg
  if not image or image:len() == 0 then
    image = vim.fn.expand "%:p"
  end
  M.show_image(image)
end, { nargs = "?", complete = "file" })

vim.api.nvim_create_user_command("ImageToggle", function()
  M.enabled = not M.enabled
end, {})

local image_enter_group_id = vim.api.nvim_create_augroup("ImageEnter", { clear = true })
vim.api.nvim_create_autocmd({ "BufEnter" }, {
  group = image_enter_group_id,
  pattern = { "*.jpg", "*.png", "*.jpeg" },
  callback = function(ev)
    if M.enabled then
      M.show_image(ev.file)
    end
  end,
})

return M
