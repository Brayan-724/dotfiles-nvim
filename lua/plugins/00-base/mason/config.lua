return {
  after_config = function(_, opts)
    -- add binaries installed by mason.nvim to path
    local is_windows = vim.loop.os_uname().sysname == "Windows_NT"
    vim.env.PATH = vim.fn.stdpath "data" .. "/mason/bin" .. (is_windows and ";" or ":") .. vim.env.PATH

    vim.api.nvim_create_user_command("MasonInstallAll", function()
      vim.cmd("MasonInstall " .. table.concat(opts.ensure_installed, " "))
    end, {})

    vim.g.mason_binaries_list = opts.ensure_installed
  end
}
