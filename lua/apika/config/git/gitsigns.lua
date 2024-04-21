local M = {}

M.opts = {
  signs = {
    add = { text = "│", hl = "DiffAdd", numhl = "GitSignsAddNr" },
    change = { text = "│", hl = "DiffChange", numhl = "GitSignsChangeNr" },
    delete = { text = "󰍵", hl = "DiffDelete", numhl = "GitSignsDeleteNr" },
    topdelete = { text = "‾", hl = "DiffDelete", numhl = "GitSignsDeleteNr" },
    changedelete = { text = "~", hl = "DiffChangeDelete", numhl = "GitSignsChangeNr" },
    untracked = { text = "│", hl = "GitSignsAdd", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
  },
}

M.mappings = {
  n = {
    -- Navigation through hunks
    ["]c"] = {
      function()
        if vim.wo.diff then
          return "]c"
        end
        vim.schedule(function()
          require("gitsigns").next_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to next hunk",
      opts = { expr = true },
    },

    ["[c"] = {
      function()
        if vim.wo.diff then
          return "[c"
        end
        vim.schedule(function()
          require("gitsigns").prev_hunk()
        end)
        return "<Ignore>"
      end,
      "Jump to prev hunk",
      opts = { expr = true },
    },

    -- Actions
    ["<leader>rh"] = {
      function()
        require("gitsigns").reset_hunk()
      end,
      "Reset hunk",
    },

    ["<leader>ph"] = {
      function()
        require("gitsigns").preview_hunk()
      end,
      "Preview hunk",
    },

    ["<leader>gb"] = {
      function()
        package.loaded.gitsigns.blame_line()
      end,
      "Blame line",
    },

    ["<leader>td"] = {
      function()
        require("gitsigns").toggle_deleted()
      end,
      "Toggle deleted",
    },
  },
}

local colors = require "apika.theme.colors"
M.theme = {
  GitSignsAdd = { bg = colors.term_background },
}

return M
