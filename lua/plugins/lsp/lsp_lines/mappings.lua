local STATE_INLINE = 0
local STATE_LINES = 1
local STATE_FLOAT = 2

local default_config = {
  prefix = "",
  spacing = 5,
  min = { severity = "Warning" },
}

return {
  n = {
    ["<leader>lf"] = {
      function () 
        if vim.b.diagnostics_state == nil then
          vim.b.diagnostics_state = STATE_INLINE
        end

        if vim.b.diagnostics_state ~= STATE_INLINE then
          vim.b.diagnostics_state = STATE_FLOAT
          vim.diagnostic.open_float { border = "rounded" }
        else
          vim.b.diagnostics_state = STATE_LINES

          local bufnr = vim.api.nvim_get_current_buf()

          vim.diagnostic.show(nil, bufnr, nil, {
            virtual_text = false,
            virtual_lines = vim.g.lsp_lines_opts
          })

          vim.b.remove_lsp_lines_autocmd = vim.api.nvim_create_autocmd("CursorMoved", {
            buffer = bufnr,
            once = true,
            callback = function () 
              vim.b.diagnostics_state = STATE_INLINE

              vim.diagnostic.show(nil, bufnr, nil, {
                virtual_text = default_config,
                virtual_lines = false,
              })
            end
          })
        end
      end,
      "Toggle lsp_lines"
    },
    ["<leader>lF"] = {
      function () 
        local bufnr = vim.api.nvim_get_current_buf()

        vim.b.diagnostics_state = STATE_INLINE
        vim.diagnostic.show(nil, bufnr, nil, {
          virtual_text = default_config,
          virtual_lines = false,
        })
      end,
      "Force reset for lsp_lines"
    }
  }
}
