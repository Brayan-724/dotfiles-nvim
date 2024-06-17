vim.filetype.add {
  extension = {
    pest = "pest",
  },
}

return {
  "pest-parser/pest.vim",
  ft = "pest",
  config = function ()
    require "pest-vim".setup {}
  end
}
