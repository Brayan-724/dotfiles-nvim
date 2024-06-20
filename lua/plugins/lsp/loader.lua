-- Partially from https://github.com/lsproule/lsps-manager

local M = {}

M.enabled_servers = {}
M.servers = {}

M.path = vim.fn.stdpath "config" .. "/lua/lsps/"

M.load = function()
  for _, file in pairs(vim.fn.readdir(M.path, [[v:val =~ '\.lua$']])) do
    local data = require("lsps." .. file:gsub("%.lua$", ""))
    M.servers[data[1]] = {}
    data.enabled = type(data.enabled) == "nil" and true or data.enabled
    if data.enabled then
      M.servers[data[1]] = data
    end
    M.servers[data[1]].enabled = data.enabled
    M.enabled_servers[data[1]] = data.enabled
  end
end

M.to_json = function()
  local file = io.open(vim.fn.stdpath "config" .. "/servers.json", "w")
  if not file then
    vim.notify "Error opening file"
    return
  end
  file:write(vim.json.encode(M.enabled_servers))
  file:flush()
end

M.from_json = function()
  local file = io.open(vim.fn.stdpath "config" .. "/servers.json", "r")

  if not file then
    M.to_json()
    return
  end

  local data = file:read "*a"
  if data == nil then
    vim.notify "No data in file"
    return
  end

  for server, enabled in pairs(vim.json.decode(data)) do
    M.servers[server].enabled = enabled
  end
end

M.update_json = function(server)
  local file = io.open(vim.fn.stdpath "config" .. "/servers.json", "r")
  if not file then
    M.to_json()
    return
  end

  local data = vim.json.decode(file:read "*a")
  if data[server] == nil then
    data[server] = true
  elseif data[server] then
    data[server] = false
  elseif not data[server] then
    data[server] = true
  else
    data[server] = not data[server]
  end

  M.enabled_servers = data
  M.to_json()
end

local function toggle_server(server)
  M.update_json(server)
end

M.telescope_toggle = function()
  local finders = require "telescope.finders"
  local conf = require("telescope.config").values
  local telescope_picker = require "telescope.pickers"
  local server_data = {}
  for server, _ in pairs(M.servers) do
    local server_string = "" .. server .. " " .. (M.servers[server].enabled and "enabled" or "disabled")
    table.insert(server_data, server_string)
  end

  telescope_picker
    .new({}, {
      prompt_title = "LSP Servers",
      finder = finders.new_table {
        results = server_data,
      },
      sorter = conf.generic_sorter {},
      attach_mappings = function(prompt_bufnr, map)
        local toggle = function()
          local selection = require("telescope.actions.state").get_selected_entry()
          local server = selection.value:match "(.+)%s"
          toggle_server(server)
          require("telescope.actions").move_selection_next(prompt_bufnr)
        end

        local toggle_and_quit = function()
          toggle()
          require("telescope.actions").close(prompt_bufnr)
        end

        map("i", "<CR>", toggle_and_quit)
        map("n", "<CR>", toggle_and_quit)

        map("n", "e", toggle)
        return true
      end,
    })
    :find()
end

M.setup_servers = function()
  local lspconfig = require "lspconfig"

  for server, config in pairs(M.servers) do
    local before_config = config.before_config
    config.before_config = nil

    local _config = config.config
    config.config = nil

    local after_config = config.before_config
    config.after_config = nil

    if M.enabled_servers[server] then
      local opts = config

      if before_config then
        before_config()
      end

      if type(_config) == "function" then
        opts = _config()
      end

      lspconfig[server].setup(opts)

      if after_config then
        after_config()
      end
    end
  end
end

M.load()
M.from_json()
M.setup_servers()

vim.api.nvim_create_user_command("ToggleServer", function()
  M.telescope_toggle()
end, {})
