local lsp_utils = require "apika.lsp"

lsp_utils.setup("rust_analyzer", {
  settings = {
    ["rust-analyzer"] = {
      assist = {
        importEnforceGranularity = true,
        importPrefix = "create",
      },
      cache = {
        warmup = false,
      },
      cachePriming = {
        enable = false,
      },
      cargo = {
        allFeatures = true,
        buildScripts = {
          enable = true,
        },
      },
      completion = {
        autoimport = {
          enable = true,
        },
        postfix = {
          enable = false,
        },
      },
      diagnostics = {
        enable = true,
        experimental = {
          enable = true,
        },
      },
      imports = {
        group = {
          enable = true,
        },
        granularity = {
          group = "module",
        },
        prefix = "self",
      },
      procMacros = {
        enable = false, -- FIX: napi ignore doesn't work
        ignored = {
          ["napi-derive"] = { "napi" },
        },
      },

      lru = {
        capacity = 64,
      },
      inlayHints = {
        expressionAdjustmentHints = {
          enabled = true,
        },
      },
    },
  },
})
