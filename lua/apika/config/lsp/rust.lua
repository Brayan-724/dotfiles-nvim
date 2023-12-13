local lsp_utils = require "apika.lsp"

lsp_utils.setup("rust_analyzer", {
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
})
