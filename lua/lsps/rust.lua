return {
  "rust_analyzer",
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
        chainingHints = {
          enable = true,
        },
        closureReturnTypeHints = {
          enable = false,
        },
        expressionAdjustmentHints = {
          enable = true,
          hideOutsideUnsafe = true,
        },
        parameterHints = {
          enable = false,
        },
        renderColons = false,
        typeHints = {
          enable = false,
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
}
