return {
  trigger_events = {
    immediate_save = { "InsertLeave", "TextChanged" },
    defer_save = {},
    cancel_deferred_save = {},
  },
  callbacks = {
    after_saving = function()
      vim.schedule(function()
          require("apika.fmt").run()
      end)
    end,
  },
}
