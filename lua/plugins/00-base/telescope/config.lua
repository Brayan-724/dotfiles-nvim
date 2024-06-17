return {
  after_config = function(_, opts)
    local telescope = require "telescope"

    -- load extensions
    for _, ext in ipairs(opts.extensions_list) do
      telescope.load_extension(ext)
    end
  end
}
