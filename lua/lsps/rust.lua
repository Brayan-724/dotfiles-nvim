function get_root_dir(fname)
  local cargo_crate_dir = require("lspconfig.util").root_pattern 'Cargo.toml'(fname)
  local cargo_workspace_root

  if cargo_crate_dir ~= nil then
    local cmd = {
      'metadata',
      '--no-deps',
      '--format-version',
      '1',
      '--manifest-path',
      require("lspconfig.util").path.join(cargo_crate_dir, 'Cargo.toml'),
    }

    
    local Job = require'plenary.job'

    local result = Job:new({
      command = 'cargo',
      args = cmd,
      on_exit = function(j, return_val) end,
    }):sync()

    if result and result[1] then
      result = vim.json.decode(table.concat(result, ''))
      if result['workspace_root'] then
        cargo_workspace_root = vim.fs.normalize(result['workspace_root'])
      end
    end
  end

  return cargo_workspace_root or cargo_crate_dir
end

return {
  "rust_analyzer",
  opts = {
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
<<<<<<< Updated upstream
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
=======
      prefix = "self",
    },
    inlayHints = {
      expressionAdjustmentHints = {
        enabled = true,
>>>>>>> Stashed changes
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
  config = function(lspconfig, settings)
    local group = vim.api.nvim_create_augroup("RustAutocmds", { clear = true })

    vim.api.nvim_create_autocmd({"VimEnter", "BufEnter", "BufWinEnter"}, {
      pattern = "*.rs",
      group = group,
      callback = function(ev)
        local fname = vim.api.nvim_buf_get_name(0)
        local root_dir = get_root_dir(fname)
        local is_standalone = root_dir == nil

        if not is_standalone then
          return
        end

        root_dir = root_dir or require("lspconfig.util").path.dirname(fname)
        --
        -- local opts = {
        --   root_dir = function () return root_dir end,
        --   init_options = is_standalone and { detachedFiles = { fname } } or {},
        --   settings = {
        --     ["rust-analyzer"] = settings,
        --   },
        -- }

        local config = {
          root_dir = root_dir,
          capabilities = require("lspconfig.util").default_config.capabilities,
          cmd = { "rust-analyzer" },
          filetypes = { "rust" },
          init_options = is_standalone and { detachedFiles = { vim.api.nvim_buf_get_name(0) } } or {},
          name = "rust_analyzer",
          on_init = function(client)
            local current_buf = vim.api.nvim_get_current_buf()
            vim.lsp.buf_attach_client(0, client.id)
            local on_attach = require("lspconfig.util").default_config.on_attach
            if on_attach then
              on_attach(client, current_buf)
            end
          end,
        }

        vim.lsp.start_client(config)
      end
    })

    -- local fname = vim.api.nvim_buf_get_name(0)
    -- local root_dir = get_root_dir(fname)
    -- local is_standalone = root_dir == nil
    -- root_dir = root_dir or require("lspconfig.util").path.dirname(fname)
    --
    -- local opts = {
    --   root_dir = function () return root_dir end,
    --   init_options = is_standalone and { detachedFiles = { fname } } or {},
    --   settings = {
    --     ["rust-analyzer"] = settings,
    --   },
    -- }

    lspconfig.rust_analyzer.setup(settings)
  end
}
