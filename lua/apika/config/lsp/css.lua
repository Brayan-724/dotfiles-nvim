local lsp_utils = require "apika.lsp"

lsp_utils.capabilities.textDocument.completion.completionItem.snippetSupport = true
lsp_utils.setup("cssls", {
  filetypes = { "css", "scss", "sass" },
  single_file_support = true,
})
