-- require("apika.plugins").setup()
local utils = require "apika.utils"

---@param self string
---@param suffix string
---@return boolean
function string:endswith(suffix)
  return self:sub(-#suffix) == suffix
end

function string:startswith(prefix)
  return self:sub(1, #prefix) == prefix
end

local plugins_path = vim.fn.stdpath "config" .. "/lua" .. "/plugins"

local plugins = {}

local last_dir = { plugins_path }

local has_which_key, which_key = pcall(require, "which-key")

for dir, filetype in utils.scan_dir_nested(plugins_path) do
  if filetype == "IGNORE THIS" then
    table.remove(last_dir, #last_dir)
    goto continue
  end

  if filetype == "file" then
    goto continue
  end
  -- filetype = "directory"

  table.insert(last_dir, dir)

  ---@type string
  local plugin = dir
  local plugin_name = plugin

  -- Gets last part of the path
  local starts, ends = plugin_name:find("/[^/]+$")
  if starts ~= nil then
    plugin_name = plugin_name:sub(starts + 1, ends)
  end

  -- Ignore plugins with prefix "_"
  if plugin_name:startswith "_" then
    vim.notify_once("ignoring " .. plugin)
    goto continue
  end

  -- Import relative to the plugin
  local require_ = function(s)
    return dofile(plugin .. "/" .. s .. ".lua")
  end

  local require_opt = function(s)
    local has_file, content = pcall(require_, s)

    if has_file then
      return true, content
    elseif content:find("No such file", 0, true) == nil then
      error("[Error loading " .. plugin_name .. "] " .. content)
    end

    return false, null
  end


  local has_mappings, mappings = require_opt "mappings"

  if has_mappings then
    mappings = utils.normalize_mapping(mappings)
    utils.set_mappings_normalized(mappings)
  end

  local has_plugin_config, plugin_config = require_opt "init"

  if has_plugin_config then
    -- vim.notify("Loading: " .. plugin, vim.log.levels.TRACE)

    plugin_name = plugin_config.name or plugin_name

    local has_config, config = require_opt "config"

    if has_config then
      if type(config) == "function" then
        plugin_config.config = config
      elseif type(config) == "table" then
        if plugin_config.name == nil then
          error("plugin " .. plugin_name .. " doesn't have 'name' field")
        end

        plugin_config.config = function(p, opts)
          if type(config.before_config) == "function" then
            config.before_config(p, opts)
          end

          local setup = require(plugin_config.name).setup
          if type(setup) == "function" then
            setup(opts)
          end

          if type(config.after_config) == "function" then
            config.after_config(p, opts)
          end
        end
      end
    end

    local has_opts, opts = require_opt("opts")

    if has_opts then
      plugin_config.opts = opts
    end

    table.insert(plugins, plugin_config)
    goto continue
  end

  if has_mappings and mappings.master and has_which_key then
    which_key.register { [mappings.master] = { name = plugin_name } }
  end

  local has_theme, theme = require_opt "theme"

  if has_theme then
    -- vim.notify("Loading Theme: " .. plugin, vim.log.levels.TRACE)
    utils.set_highlights(theme)
  end

  ::continue::
end

require("lazy").setup(plugins)
