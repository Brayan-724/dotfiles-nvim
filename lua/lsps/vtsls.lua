local vue_plugin = {
  name = '@vue/typescript-plugin',
  -- FIXME: Retrieve path from nix
  location = "/nix/store/bcfqi2i5hjkss1maii1yyl8zmjh32qk5-vue-language-server-3.2.1/lib/language-tools/packages/language-server",
  languages = { 'vue' },
  configNamespace = 'typescript',
}

return {
  "vtsls",

  settings = {
    vtsls = {
      tsserver = {
        globalPlugins = {
          vue_plugin,
        },
      },
    },
  },

  filetypes = { 'typescript', 'javascript', 'javascriptreact', 'typescriptreact', 'vue' },
}
