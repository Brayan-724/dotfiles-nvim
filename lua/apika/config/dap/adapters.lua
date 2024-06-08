local dap = require "dap"

dap.adapters.lldb = {
  type = "executable",
  command = "/usr/bin/lldb-vscode",
  name = "lldb",
}

dap.adapters.codelldb = function(callback, config)
  callback {
    type = "server",
    port = "${port}",
    executable = {
      command = "/usr/bin/codelldb",
      args = { "--port", "${port}" },
    },
  }
end
