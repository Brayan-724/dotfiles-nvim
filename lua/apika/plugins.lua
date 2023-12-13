local M = {}

local plugins = {
  { import = "apika.plugins.base" },
}

function M.setup()
  require "lazy".setup(plugins)
end

function M.reload()
  require "lazy".reload(plugins)
end

return M
