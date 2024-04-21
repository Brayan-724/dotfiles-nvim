local M = {}

--- @param str string
function M.echo(str)
  vim.cmd "redraw"
  vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end

--- @param args table
function M.shell_call(args)
  local output = vim.fn.system(args)
  assert(vim.v.shell_error == 0, "External call failed with error code: " .. vim.v.shell_error .. "\n" .. output)
end

--- @param t1 table
--- @param t2 table
function M.merge(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" then
      if type(t1[k] or false) == "table" then
        M.merge(t1[k] or {}, t2[k] or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
  return t1
end

--- @param mappings table
function M.set_mapping(mappings)
  for mode, keybinds in pairs(mappings) do
    for keybind, mapping_info in pairs(keybinds) do
      -- merge default + user opts
      local opts = mapping_info.opts or {}
      opts.desc = mapping_info[2]

      vim.keymap.set(mode, keybind, mapping_info[1], opts)
    end
  end
end

---@alias ExecConfigProp<T> fun(m:table|function|string): T
---@alias ConfigConfigProp<T> fun(m?:table|function|string): T

---@class ConfigProp<T>: { exec: ExecConfigProp<T>, exec_config: ConfigConfigProp<T> }

---@generic T
---@param propname string
---@param config_base string
---@param fn_exec fun(value: table): T
---@param fn_resolve fun(self: ConfigProp<T>, value: LazyPlugin|function|string, old: function): T
---@return ConfigProp<T>
local function new_config_property(propname, config_base, fn_exec, fn_resolve)
  ---@as ConfigProp
  local R = {}

  function R.exec(m, is_prop)
    if type(m) == "nil" then
      return {}
    elseif type(m) == "string" then -- Module
      return R.exec(require(m), false)
    elseif type(m) == "function" then
      return R.exec(m(), is_prop)
    elseif type(m) ~= "table" then -- Only tables from here
      return {}
    elseif type(m[propname]) ~= "nil" then
      return R.exec(m[propname], true)
    elseif is_prop == false then
      return {}
    end

    return fn_exec(m)
  end

  function R.exec_config(mod)
    if type(mod) == "string" then
      return R.exec(config_base .. "." .. mod, false)
    end

    if type(mod) == "table" then
      local modname = mod.apika_config
      if type(modname) ~= "string" then
        vim.notify("Cannot get `apika_config` from " .. mod[0], vim.log.levels.ERROR)
        return
      end
      return R.exec_config(modname)
    end

    if type(mod) == "function" then
      return function(plugin, ...)
        local args = ...
        fn_resolve(R, plugin, function()
          mod(plugin, args)
        end)
      end
    end
  end

  return R
end

local _opts = new_config_property("opts", "apika.config", function(value)
  return value
end, function(R, value, old)
  local opts = R.exec_config(value)
  return vim.tbl_deep_extend("force", opts, old())
end)

M.opts = _opts.exec
M.opts_config = _opts.exec_config

local _mappings = new_config_property("mappings", "apika.config", function(value)
  return M.set_mapping(value)
end, function(R, value, old)
  R.exec_config(value)
  old()
end)

M.keymap = _mappings.exec
M.keymap_config = _mappings.exec_config

local _theme = new_config_property("theme", "apika.config", function(value)
  return require("apika.theme.utils").set_highlights(value)
end, function(R, value, old)
  R.exec_config(value)
  old()
end)

M.theme = _theme.exec
M.theme_config = _theme.exec_config

---@type ConfigConfigProp
M.config = function(v)
  if type(v) == "function" then
    return M.keymap_config(M.theme_config(v))
  else
    M.keymap_config(v)
    M.theme_config(v)
  end
end

return M
