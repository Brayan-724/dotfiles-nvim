local M = {}

function M.config()
  local dap = require "dap"
  local dapui = require "dapui"

  require "apika.config.dap.adapters"
  require "apika.config.dap.configs"

  dap.listeners.before.attach.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.launch.dapui_config = function()
    dapui.open()
  end
  dap.listeners.before.event_terminated.dapui_config = function()
    dapui.close()
  end
  dap.listeners.before.event_exited.dapui_config = function()
    dapui.close()
  end
end

return M
