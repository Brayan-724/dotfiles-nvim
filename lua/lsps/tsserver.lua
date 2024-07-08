local lspconfig = require "lspconfig"

return {
  "tsserver",
  root_dir = function(fname)
    local has_package = lspconfig.util.root_pattern "package.json"
    local has_deno = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
    return not has_deno(fname) and has_package(fname)
  end,
  single_file_support = false,
}
