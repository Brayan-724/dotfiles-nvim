local lspconfig = require "lspconfig"

-- FIXME: Retrieve path from nix
local vue_language_server_path = '/nix/store/bcfqi2i5hjkss1maii1yyl8zmjh32qk5-vue-language-server-3.2.1/lib/language-tools/packages/language-server'
local tsserver_filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' }
local vue_plugin = {
  name = '@vue/typescript-plugin',
  location = vue_language_server_path,
  languages = { 'vue' },
  configNamespace = 'typescript',
}

return {
  "ts_ls",
  root_dir = function(fname)
    local has_package = lspconfig.util.root_pattern "package.json"
    local has_deno = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
    return not has_deno(fname) and has_package(fname)
  end,
  single_file_support = false,


  init_options = {
    plugins = {
      vue_plugin,
    },
  },
  filetypes = tsserver_filetypes,
}
