---@type MappingsTable
local M = {}

M.general = {
  n = {
    [";"] = { ":", "enter command mode", opts = { nowait = true } },
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
