return function()
  local b = require "null-ls".builtins

  local sources = {
    -- webdev stuff
    b.formatting.biome.with {
      filetypes = { "json", "jsonc" },
    },
    b.formatting.prettier.with {
      filetypes = { "html", "css", "sass", "scss", "less", "yaml", "markdown", "mdx", "astro", "toml" },
    },
    b.diagnostics.stylelint.with {
      filetypes = { "css" },
      extra_args = {
        function(params)
          local ext = vim.fn.fnamemodify(params.bufname, ":e")
          local custom_syntax = {
            ["sass"] = "postcss-sass",
            ["scss"] = "postcss-scss",
          }

          return custom_syntax[ext] and { "--custom-syntax", custom_syntax[ext] } or {}
        end,
      },
      condition = function(utils)
          return utils.root_has_file({ ".stylelintrc.json" })
      end,
    },

    -- Lua
    b.formatting.stylua,
    b.formatting.fnlfmt.with { extra_filetypes = { "yuck" } },

    -- cpp
    b.formatting.clang_format,

    -- git
    b.code_actions.gitsigns,
  }

  return sources
end
