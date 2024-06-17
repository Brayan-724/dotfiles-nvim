return {
  "lukas-reineke/indent-blankline.nvim",
  opts = {
    enabled = true,
    exclude = {
      filetypes = {
        "help",
        "terminal",
        "lazy",
        "lspinfo",
        "TelescopePrompt",
        "TelescopeResults",
        "mason",
        "dashboard",
        "",
      },
    },
  },
  config = function(_, opts)
    require("ibl").setup(opts)

    require "apika.theme.blankline"
  end,
}
