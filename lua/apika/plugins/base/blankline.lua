return {
  "lukas-reineke/indent-blankline.nvim",
  -- init = function()
  --    require("core.utils").lazy_load "indent-blankline.nvim"
  -- end,
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
