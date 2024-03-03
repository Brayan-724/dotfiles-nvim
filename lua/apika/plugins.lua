local M = {}

local plugins = {
  { import = "apika.plugins.base" },
  { import = "apika.plugins.git" },
  { import = "apika.plugins.rust" },
}

function M.setup()
  require "lazy".setup(plugins)
end

function M.reload()
  require "lazy".reload(plugins)
end

return M
