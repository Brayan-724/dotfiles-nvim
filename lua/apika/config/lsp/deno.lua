local lsp_utils = require "apika.lsp"

lsp_utils.setup("denols", {
  root_dir = lsp_utils.lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
  settings = {
    deno = {
      enable = true,
      suggest = {
        imports = {
          hosts = {
            ["https://deno.land"] = true,
          },
        },
      },
    },
  },
})
