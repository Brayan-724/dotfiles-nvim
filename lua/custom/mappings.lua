---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "Enter command mode", opts = { nowait = true } },
    ["gr"] = {
      function()
        vim.cmd "Telescope lsp_references"
      end,
      "Go to references",
    },

    ["gd"] = {
      function()
        vim.cmd "Telescope lsp_definitions"
      end,
      "Go to definitions",
    },

    ["<leader>q"] = {
      function()
        vim.cmd "Telescope diagnostics"
      end,
      "Go to definitions",
    },

    ["<leader>cd"] = {
      function()
        vim.cmd "Telescope zoxide list"
      end,
      "Go to definitions",
    },

    ["<leader>fm"] = {
      function()
        require("custom.fmt").run()
      end,
      "lsp formatting",
    },
  },
}

return M
