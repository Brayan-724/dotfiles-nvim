return {
  n = {
    ["<leader>lf"] = {
      function () 
        if vim.diagnostic.config().virtual_text == false then
          vim.diagnostic.open_float { border = "rounded" }
        else
          vim.g.old_virtual_text_state = vim.diagnostic.config().virtual_text
          vim.diagnostic.config {
            virtual_text = false,
            virtual_lines = vim.g.lsp_lines_opts
          }

          vim.b.remove_lsp_lines_autocmd = vim.api.nvim_create_autocmd("CursorMoved", {
            buffer = vim.api.nvim_get_current_buf(),
            once = true,
            callback = function () 
              vim.diagnostic.config {
                virtual_text = vim.g.old_virtual_text_state,
                virtual_lines = false,
              }
            end
          })
        end
      end,
      "Toggle lsp_lines"
    }
  }
}
