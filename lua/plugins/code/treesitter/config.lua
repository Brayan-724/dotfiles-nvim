return function(_, opts)
  local parser_config = require("nvim-treesitter.parsers").get_parser_configs()
  parser_config.aml3 = require("plugins.code.langs.aml3.ts")
  parser_config.edge = require("plugins.code.langs.edge.ts")
  parser_config.nc = require("plugins.code.langs.nc.ts")

  require("nvim-treesitter.configs").setup(opts)
end
