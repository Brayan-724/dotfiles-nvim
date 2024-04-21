local M = {}

function M.opts()
  return {
    ensure_installed = {
      "lua",
      "vim",
      "html",
      "css",
      "javascript",
      "c",
      "markdown",
      "markdown_inline",
    },

    highlight = {
      enable = true,
      use_languagetree = true,
    },

    indent = {
      enable = true,
      disable = {
        "python",
      },
    },
  }
end

function M.config()
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.aml3 = {
    install_info = {
      url = "~/projects/tree-sitter-aml3",
      files = { "src/parser.c" }
    },
  }

  -- require("vim.treesitter.query").set("aml3", "highlights", "(command) @keyword")

  vim.filetype.add {
    extension = {
      aml3 = "aml3",
    },
  }
end

return M
