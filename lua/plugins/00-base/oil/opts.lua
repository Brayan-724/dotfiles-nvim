return {
  columns = {
    { "mtime", highlight = "OilMtime" },
    { "permissions", highlight = "OilParmissions" },
    { "size", highlight = "OilSize" },
    "icon",
  },

  default_file_explorer = true,

  delete_to_trash = true,

  prompt_save_on_select_new_entry = false,

  -- Keymaps
  use_default_keymaps = false,

  keymaps = {
    ["g?"] = "actions.show_help",

    ["<CR>"] = "actions.select",
    ["<C-s>"] = { "actions.select", opts = { vertical = true }, desc = "Open the entry in a vertical split" },
    ["<C-v>"] = { "actions.select", opts = { horizontal = true }, desc = "Open the entry in a horizontal split" },
    ["<C-t>"] = { "actions.select", opts = { tab = true }, desc = "Open the entry in new tab" },

    ["<C-p>"] = "actions.preview",
    ["<C-c>"] = "actions.close",
    ["<C-r>"] = "actions.refresh",

    ["-"] = "actions.parent",
    ["`"] = "actions.cd",
    ["~"] = { "actions.cd", opts = { scope = "tab" }, desc = ":tcd to the current oil directory", mode = "n" },
    ["gs"] = "actions.change_sort",
    ["gx"] = "actions.open_external",
    ["<leader>w"] = "actions.open_terminal",
    ["g."] = "actions.toggle_hidden",
    ["g\\"] = "actions.toggle_trash",

    ["<leader>:"] = {
        "actions.open_cmdline",
        opts = {
            shorten_path = true,
            modify = ":h",
        },
        desc = "Open the command line with the current directory as an argument",
    },

  },
}
