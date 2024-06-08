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
        allFeatures = false,
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
      inlayHints = {
        expressionAdjustmentHints = {
          enabled = true,
        },
        parameterHints = {
          enabled = false,
        },
        typeHints = {
          enabled = false,
        },
      },
      lru = {
        capacity = 64,
      },
      procMacros = {
        enable = true, -- FIX: napi ignore doesn't work
        ignored = {
          ["napi-derive"] = { "napi" },
          ["tokio"] = { "main" },
        },
      },

    },
  },
})
