-- require("apika.plugins").setup()
local utils = require "apika.utils"

function string:endswith(suffix)
  return self:sub(-#suffix) == suffix
end

local lua_config = vim.fn.stdpath "config" .. "/lua"
local plugins_path = lua_config .. "/plugins"

local plugins = {}

local last_dir = {}

for file, filetype in utils.scan_dir_nested(plugins_path) do
  if filetype == "IGNORE THIS" then
    table.remove(last_dir, #last_dir)
    goto continue
  end

  if filetype == "directory" then
    table.insert(last_dir, file)
    goto continue
  end

  if file:endswith "init.lua" then
    ---@type string
    local plugin = last_dir[#last_dir]

    -- vim.notify("Loading: " .. plugin, vim.log.levels.TRACE)

    local require_ = function(s) return dofile(plugin .. "/" .. s .. ".lua") end


    local plugin_config = require_ "init"
    local plugin_name = plugin_config.name or plugin_config[1] or plugin

    local has_config, config = pcall(require_, "config")

    if has_config then
      if type(config) == "function" then
        plugin_config.config = config
      elseif type(config) == "table" then
        if plugin_config.name == nil then
          error("plugin " .. plugin_name .. " doesn't have 'name' field")
        end

        plugin_config.config = function(plugin, opts)
          if type(config.before_config) == "function" then
            config.before_config(plugin, opts)
          end

          require(plugin_config.name).setup(opts)

          if type(config.after_config) == "function" then
            config.after_config(plugin, opts)
          end
        end
      end
    elseif config:find("No such file", 0, true) == nil then
      error("[Error loading " .. plugin_name .. "] " .. config)
    end

    local has_opts, opts = pcall(require_, "opts")

    if has_opts then
      plugin_config.opts = opts
    elseif opts:find("No such file", 0, true) == nil then
      error("[Error loading " .. plugin_name .. "] " .. opts)
    end

    local has_mapping, mapping = pcall(require_, "mappings")

    if has_mapping then
      local mappings = utils.normalize_mapping(mapping)
      utils.set_mappings_normalized(mappings)

      plugin_config.keys = utils.keymaps_to_lazy(mappings)

      local has_wk, wk = pcall(require, "which-key") 
      if has_wk then
        if mappings.master then
          wk.register({ [mappings.master] = { name = plugin_name } })
        end
      end
    elseif mappings ~= nil and mappings:find("No such file", 0, true) == nil then
      error("[Error loading " .. plugin_name .. "] " .. mappings)
    end

    local has_theme, theme = pcall(require_, "theme")

    if has_theme then
      utils.set_highlights(theme)
    elseif theme:find("No such file", 0, true) == nil then
      error("[Error loading " .. plugin_name .. "] " .. theme)
    end

    table.insert(plugins, plugin_config)
    goto continue
  end

  if file:endswith "theme.lua" then
    ---@type string
    local plugin = last_dir[#last_dir]

    -- vim.notify("Loading Theme: " .. plugin, vim.log.levels.TRACE)

    local require_ = function(s) return dofile(plugin .. "/" .. s .. ".lua") end

    local has_theme, theme = pcall(require_, "theme")

    if has_theme then
      utils.set_highlights(theme)
    elseif theme:find("No such file", 0, true) == nil then
      error("[Error loading " .. plugin_name .. "] " .. theme)
    end
  end

  ::continue::
end

require("lazy").setup(plugins)
