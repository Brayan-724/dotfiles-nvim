local lsp_utils = require "apika.lsp"

lsp_utils.setup("tsserver", {
  root_dir = function(fname)
    local has_package = lsp_utils.lspconfig.util.root_pattern "package.json"
    local has_deno = lsp_utils.lspconfig.util.root_pattern("deno.json", "deno.jsonc")
    return not has_deno(fname) and has_package(fname)
  end,
  single_file_support = false,
})
