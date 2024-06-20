return {
  after_config = function()
    require "plugins.lsp.config_server"
    require "plugins.lsp.config_ui"
    require "plugins.lsp.loader"
  end,
}
