local present, null_ls = pcall(require, "null-ls")

if not present then
  return
end

local b = null_ls.builtins

local sources = {

  -- webdev stuff
  b.formatting.deno_fmt,
  b.formatting.prettier.with {
    filetypes = { "html", "css", "sass", "scss", "less", "json", "yaml", "markdown", "mdx", "astro" },
  },
  b.diagnostics.stylelint.with {
    filetypes = { "css" },
    extra_args = {
      function(params)
        require("notify")("TESTING")
        vim.notify(params.bufname)
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
  -- b.code_actions.luasnip,

  -- cpp
  b.formatting.clang_format,

  -- rust
  b.formatting.rustfmt.with { extra_args = { "--edition=2022" } },
  b.formatting.dprint.with { filetypes = { "toml" } },

  -- dart
  b.formatting.dart_format,

  -- git
  b.code_actions.gitsigns,

  -- python
  b.diagnostics.ruff,
}

null_ls.setup {
  debug = true,
  sources = sources,
}
