return function(_, opts)
  vim.api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = function()
      local parser_config = require("nvim-treesitter.parsers")
      parser_config.aml3 = require("plugins.code.langs.aml3.ts")
      parser_config.edge = require("plugins.code.langs.edge.ts")
      parser_config.just = require("plugins.code.langs.just.ts")
      -- parser_config.nc = require("plugins.code.langs.nc.ts")
    end
  })

  require("nvim-treesitter.install").prefer_git = true
  require("nvim-treesitter").setup(opts)

  vim.api.nvim_create_autocmd("Filetype", {
    callback = function ()
      pcall(vim.treesitter.start);
    end
  });
end
