return {
  "rust_analyzer",
  settings = {
    ["rust-analyzer"] = {
      assist = {
        emitMustUse = true,
        preferSelf = true,
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
        disabled = { "inactive-code" },
        experimental = {
          enable = true,
        },
      },
      imports = {
        granularity = {
          group = "module",
        },
        group = {
          enable = true,
        },
        merge = {
          enable = true,
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
