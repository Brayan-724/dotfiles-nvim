local function deno()
  local h = require "null-ls.helpers"
  local methods = require "null-ls.methods"

  local FORMATTING = methods.internal.FORMATTING

  local extensions = {
    javascript = "js",
    javascriptreact = "jsx",
    json = "json",
    jsonc = "jsonc",
    markdown = "md",
    typescript = "ts",
    typescriptreact = "tsx",
  }

  return h.make_builtin {
    name = "deno_fmt",
    meta = {
      url = "https://deno.land/manual/tools/formatter",
      description = "Use [Deno](https://deno.land/) to format TypeScript, JavaScript/JSON and markdown.",
      notes = {
        "`deno fmt` supports formatting JS/X, TS/X, JSON and markdown. If you only want deno to format a subset of these filetypes you can overwrite these with `.with({filetypes={}}`)",
      },
      usage = [[
local sources = {
    null_ls.builtins.formatting.deno_fmt, -- will use the source for all supported file types
    null_ls.builtins.formatting.deno_fmt.with({
		filetypes = { "markdown" }, -- only runs `deno fmt` for markdown
    }),
}]],
    },
    method = FORMATTING,
    filetypes = {
      "javascript",
      "javascriptreact",
      "json",
      "jsonc",
      "markdown",
      "typescript",
      "typescriptreact",
    },
    generator_opts = {
      command = "deno",
      args = function(_)
        return { "fmt", }
      end,
      to_stdin = false,
    },
    factory = h.formatter_factory,
  }
end

return function()
  -- require ""
  local b = require("null-ls").builtins

  return {
    -- webdev stuff
    deno(),

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
        return utils.root_has_file { ".stylelintrc.json" }
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
end
