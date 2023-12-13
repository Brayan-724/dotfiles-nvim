local function none_sources()
  local b = require "null-ls".builtins

  local sources = {
    -- webdev stuff
    b.formatting.deno_fmt,
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
    },

    -- Lua
    b.formatting.stylua,

    -- cpp
    b.formatting.clang_format,

    -- rust
    b.formatting.rustfmt.with { extra_args = { "--edition=2022" } },

    -- git
    b.code_actions.gitsigns,

    -- python
    b.diagnostics.ruff,
  }

  return sources
end

------- DEFINITION -------
return {
  "neovim/nvim-lspconfig",
  dependencies = {
    -- format & linting
    {
      "nvimtools/none-ls.nvim",
      opts = none_sources,
      config = function(_, sources)
        require "null-ls".setup {
          debug = true,
          sources = sources,
        }
      end,
    },
  },
  config = function()
    require "apika.config.lsp"
    require "apika.config.lsp.lua"
    require "apika.config.lsp.css"
    require "apika.config.lsp.deno"
    require "apika.config.lsp.tsserver"
    require "apika.config.lsp.rust"
  end,
}
