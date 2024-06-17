local common = require "plugins.dev.compilemode.common"

return {
  before_config = function()
    common.load_lock()
  end,

  after_config = function()
    local nio = require "nio" -- FIXME: nio is not recognized

    nio.run(function()
      while true do
        nio.sleep(1000)
        common.save_lock()
      end
    end)
  end,
}
