local null_ls_token = nil
local ltex_token = nil

return {
  lsp = {
    progress = { enabled = false },
    -- override markdown rendering so that **cmp** and other plugins use **Treesitter**
    override = {
      ['vim.lsp.handlers["textDocument/hover"]'] = true,
      ['vim.lsp.handlers["textDocument/signatureHelp"]'] = true,
      ["vim.lsp.util.convert_input_to_markdown_lines"] = true,
      ["vim.lsp.util.stylize_markdown"] = true,
      ["cmp.entry.get_documentation"] = true,
    },
  },
  routes = {
    -- show recording messages
    {
      view = "notify",
      filter = { event = "msg_showmode" },
    },

    -- hide written messages
    {
      filter = {
        event = "msg_show",
        kind = "",
        find = "written",
      },
      opts = { skip = true },
    },
  },

  cmdline = {
    view = "cmdline",
  },

  views = {
    cmdline_popupmenu = {
      relative = "editor",
      position = "auto",
      size = {
        width = 60,
        height = 10,
      },
      border = {
        style = "rounded",
        padding = { 0, 1 },
      },
      win_options = {
        winhighlight = { Normal = "Normal", FloatBorder = "FloatBorder" },
      },
    },
  },
  -- you can enable a preset for easier configuration
  presets = {
    bottom_search = false, -- use a classic bottom cmdline for search
    -- command_palette = true, -- position the cmdline and popupmenu together
    long_message_to_split = true, -- long messages will be sent to a split
    inc_rename = false, -- enables an input dialog for inc-rename.nvim
    lsp_doc_border = false, -- add a border to hover docs and signature help
  },
}
