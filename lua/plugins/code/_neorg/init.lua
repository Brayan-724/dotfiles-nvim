vim.filetype.add {
  extension = {
    org = "norg"
  }
}

return {
  "nvim-neorg/neorg",
  ft = "norg",
  dependencies = { "luarocks.nvim" },
  version = "v8.4.1",
  opts = {
    load = {
      ["core.completion"] = {
        config = {
          engine = "nvim-cmp",
        },
      },
      ["core.concealer"] = {},
      ["core.dirman"] = {
        config = {
          use_popup = false,
          workspaces = {
            raylia = "~/projects/raylia/",
          },
        },
      },
    },
  },
  config = true,
}
