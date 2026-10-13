return function(_, opts)
  local parsers = {
      comment = require "plugins.code.langs.comments.ts",
      aml3 = require "plugins.code.langs.aml3.ts",
      edge = require "plugins.code.langs.edge.ts",
      just = require "plugins.code.langs.just.ts",
      mcfunction = require "plugins.code.langs.mcfunction.ts",
      -- nc = require("plugins.code.langs.nc.ts"),
  }

  vim.api.nvim_create_autocmd("User", {
    pattern = "TSUpdate",
    callback = function()
      local parser_config = require "nvim-treesitter.parsers"
      for k, v in pairs(parsers) do
        parser_config[k] = v
      end
    end,
  })

  require("nvim-treesitter.install").prefer_git = true
  require("nvim-treesitter").setup(opts)

  vim.api.nvim_create_autocmd("BufRead", {
    callback = function()
      pcall(vim.treesitter.start)
    end,
  })

  vim.api.nvim_create_autocmd("Filetype", {
    callback = function()
      pcall(vim.treesitter.start)
    end,
  })
end
