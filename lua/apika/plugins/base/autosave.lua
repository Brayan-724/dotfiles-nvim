return {
  "okuuva/auto-save.nvim",
  event = { "InsertLeave", "TextChanged" },
  opts = {
    trigger_events = {
      immediate_save = { "InsertLeave", "TextChanged" },
      defer_save = {},
      cancel_defered_save = {},
    },
    execution_message = {
      enabled = false,
    },
    callbacks = {
      after_saving = function()
        vim.schedule(function()
          require("apika.fmt").run()
        end)
      end,
    },
  },
}
