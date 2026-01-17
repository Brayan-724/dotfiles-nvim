return {
  "lua_ls",
  settings = {
    Lua = {
      workspace = {
        library = {
          vim.api.nvim_get_runtime_file("", true),
          vim.env.VIMRUNTIME,
          vim.split(package.path, ";"),
          [vim.fn.expand "$VIMRUNTIME/lua"] = true,
          [vim.fn.expand "$VIMRUNTIME/lua/vim/lsp"] = true,
          [vim.fn.stdpath "data" .. "/lazy/lazy.nvim/lua/lazy"] = true,
        },

        maxPreload = 100000,
        preloadFileSize = 10000,
      },

      hint = {
        enable = true,
        paramName = "Disable",
        paramType = false,
        setType = false,
      },

      runtime = {
        version = "LuaJIT",
        path = vim.split(package.path, ";"),
      },
      diagnostics = {
        enable = true,
        globals = { "vim" },
      },
      telemetry = {
        enable = false,
      },
    },
  },
}
