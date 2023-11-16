local M = {}

M.treesitter = {
  ensure_installed = {
    "vim",
    "lua",
    "html",
    "css",
    "javascript",
    "c",
    "markdown",
    "markdown_inline",
  },
  indent = {
    enable = true,
    disable = {
      "python",
    },
  },
}

function M.telescope()
  local z_utils = require "telescope._extensions.zoxide.utils"

  return {
    borderchars = { "─", "│", "─", "│", "◢", "◣", "◤", "◥" },
    extensions = {
      zoxide = {
        prompt_title = "[ Walking on the shoulders of TJ ]",
        mappings = {
          default = {
            after_action = function(selection)
              print("Update to (" .. selection.z_score .. ") " .. selection.path)
            end,
          },
          ["<C-s>"] = {
            before_action = function(selection)
              print "before C-s"
            end,
            action = function(selection)
              vim.cmd.edit(selection.path)
            end,
          },
          -- Opens the selected entry in a new split
          ["<C-q>"] = { action = z_utils.create_basic_command "split" },
        },
      },
    },
  }
end

M.mason = {
  ensure_installed = {
    -- lua stuff
    "lua-language-server",
    "stylua",

    -- web dev stuff
    "css-lsp",
    "html-lsp",
    "typescript-language-server",
    "deno",
  },
}

-- git support in nvimtree
M.nvimtree = {
  git = {
    enable = true,
  },

  renderer = {
    highlight_git = true,
    icons = {
      show = {
        git = true,
      },
    },
  },

  view = {
    side = "right",
  },
}

vim.g.nvimtree_side = "right"

return M
