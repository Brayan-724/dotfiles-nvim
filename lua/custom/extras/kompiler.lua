local M = {}

function M.setup()
  local normal_command = 'echo "Compile mode is unsetted. Use \\"KompileSet <cmd>\\" to set a compile command"'
  local auto_command = 'echo "Auto compile mode is unsetted. Use \\"KompileSet <cmd>\\" to set a compile command"'

  vim.api.nvim_create_user_command("KompileSet", function(opts)
    normal_command = opts.args
  end, {
    nargs = "*",
  })

  vim.api.nvim_create_user_command("KompileAutoSet", function(opts)
    auto_command = opts.args
    vim.api.nvim_create_autocmd({ "BufWritePost" }, {
      group = vim.api.nvim_create_augroup("KompileAuto", {
        clear = true,
      }),
      callback = function()
        local current_win_id = vim.api.nvim_get_current_win()
        --- FIXME: this doesn't work
        vim.cmd("7split term " .. auto_command)
        vim.opt_local.relativenumber = false
        vim.api.nvim_set_current_win(current_win_id)
      end,
    })
  end, {
    nargs = "*",
  })

  vim.api.nvim_create_user_command("Kompile", function()
    vim.cmd("tab term " .. normal_command)
    vim.opt_local.relativenumber = false
  end, {})
end

return M
