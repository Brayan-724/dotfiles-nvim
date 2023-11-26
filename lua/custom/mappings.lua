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
        if vim.bo.filetype == "rust" then
          vim.cmd "!cargo fmt"
        elseif vim.bo.filetype == "astro" then
          vim.cmd "!prettier --plugin prettier-plugin-astro --write %"
        else
          vim.lsp.buf.format { async = true }
        end
      end,
      "lsp formatting",
    },
  },
}

return M
