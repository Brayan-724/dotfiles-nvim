local dap = require "dap"
local cmd_lock = vim.fn.stdpath "data" .. "/dap.cmd.lock"

---@param str string
---@return string
local function trim(str)
  str = string.gsub(str, "^%s*(.-)%s*$", "%1")
  return str
end

--- @type string|nil
local dap_lock = nil
--- @type string
local dap_cmd = "echo"
--- @type string[]
local dap_args = { "No command specified" }

local function load_lock()
  local f = io.open(cmd_lock, "r")
  if not f then
    return
  end

  local data = f:read "a"
  if type(data) == "string" then
    dap_lock = data
  end
  f:close()
end

load_lock()

local function save_lock()
  if not dap_lock then
    return
  end

  local f = io.open(cmd_lock, "w")
  if not f then
    return
  end

  local _, err = f:write(dap_lock)
  if err then
    vim.notify(err, vim.log.levels.ERROR)
  end
  f:close()
end

local function reload_cmd()
  if not dap_lock then
    return
  end

  dap_cmd = "echo"
  dap_args = {}

  local is_string = false
  local is_cmd = true
  local is_escaping = false
  local cursor_start = 0
  local cursor_end = 0

  local function process(i)
    local arg = dap_lock:sub(cursor_start, cursor_end)

    if is_cmd then
      is_cmd = false
      dap_cmd = trim(arg)
    else
      table.insert(dap_args, trim(arg))
    end

    cursor_start = i + 1
  end

  for i = 1, #dap_lock do
    local c = dap_lock:sub(i, i)

    if is_escaping then
      is_escaping = false
    end

    if c == "\\" then
      is_escaping = true
    elseif c == '"' then
      if is_string then
        is_string = false

        cursor_start = cursor_start + 1
        cursor_end = i - 1
        process(i)
      else
        is_string = true
        cursor_start = i
      end
    elseif c == " " and not is_string then
      cursor_end = i - 1
      process(i)
    end
  end

  cursor_end = #dap_lock

  if is_string then
    cursor_start = cursor_start + 1
    cursor_end = #dap_lock - 1
  end

  process(#dap_lock)
end

local lldb = {
  name = "Launch lldb",
  type = "lldb",
  request = "launch",
  program = function()
    local cmd = vim.fn.input("Compile command: ", dap_lock or (vim.fn.getcwd() .. "/"), "command")
    dap_lock = cmd

    save_lock()
    reload_cmd()

    return dap_cmd
  end,
  cwd = "${workspaceFolder}",
  stopOnEntry = false,
  args = function()
    return dap_args
  end,
}

dap.configurations.rust = {
  lldb,
}
