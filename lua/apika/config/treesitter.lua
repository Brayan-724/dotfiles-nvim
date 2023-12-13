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

return M
