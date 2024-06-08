return {
  "pest-parser/pest.vim",
  event = "BufEnter *.pest",
  config = function ()
    require "pest-vim".setup {}
  end
}
