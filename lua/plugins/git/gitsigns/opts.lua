return {
  signs = {
    add = { text = "│", hl = "DiffAdd", numhl = "GitSignsAddNr" },
    change = { text = "│", hl = "DiffChange", numhl = "GitSignsChangeNr" },
    delete = { text = "󰍵", hl = "DiffDelete", numhl = "GitSignsDeleteNr" },
    topdelete = { text = "‾", hl = "DiffDelete", numhl = "GitSignsDeleteNr" },
    changedelete = { text = "~", hl = "DiffChangeDelete", numhl = "GitSignsChangeNr" },
    untracked = { text = "│", hl = "GitSignsAdd", numhl = "GitSignsAddNr", linehl = "GitSignsAddLn" },
  },
}
