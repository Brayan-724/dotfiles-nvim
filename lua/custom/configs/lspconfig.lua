local on_attach = require("plugins.configs.lspconfig").on_attach
local capabilities = require("plugins.configs.lspconfig").capabilities

local lspconfig = require "lspconfig"

-- if you just want default config for the servers then put them in a table
local servers = { "html", "clangd", "astro" }

for _, lsp in ipairs(servers) do
  lspconfig[lsp].setup {
    on_attach = on_attach,
    capabilities = capabilities,
  }
end

capabilities.textDocument.completion.completionItem.snippetSupport = true
lspconfig.cssls.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  filetypes = { "css", "scss", "sass" },
  single_file_support = true,
}

lspconfig.denols.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = lspconfig.util.root_pattern("deno.json", "deno.jsonc"),
}

lspconfig.tsserver.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  root_dir = function(fname)
    local has_package = lspconfig.util.root_pattern "package.json"
    local has_deno = lspconfig.util.root_pattern("deno.json", "deno.jsonc")
    return not has_deno(fname) and has_package(fname)
  end,
  single_file_support = false,
}

lspconfig.rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities,
  settings = {
    ["rust-analyzer"] = {
      lru = {
        capacity = 64,
      },
      procMacro = {
        enabled = false,
      },
      inlayHints = {
        expressionAdjustmentHints = {
          enabled = true,
        },
      },
    },
  },
}
