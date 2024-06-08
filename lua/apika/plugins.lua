local M = {}

local plugins = {
  { import = "apika.plugins.lsp" },
  { import = "apika.plugins.base" },
  { import = "apika.plugins.flutter" },
  { import = "apika.plugins.git" },
  { import = "apika.plugins.rust" },
  { import = "apika.plugins.dev" },
}

function M.setup()
  require "lazy".setup(plugins)
end

function M.reload()
  require "lazy".reload(plugins)
end

return M
