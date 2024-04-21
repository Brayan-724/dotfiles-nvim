local function none_sources()
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
          debug = false,
          sources = sources,
        }
      end,
    },
  },
  config = function()
    require "apika.config.lsp"
    require "apika.config.lsp.astro"
    require "apika.config.lsp.css"
    require "apika.config.lsp.deno"
    require "apika.config.lsp.json"
    require "apika.config.lsp.lua"
    require "apika.config.lsp.python"
    require "apika.config.lsp.rust"
    require "apika.config.lsp.svelte"
    require "apika.config.lsp.toml"
    require "apika.config.lsp.tsserver"
    require "apika.config.lsp.yaml"
  end,
}
