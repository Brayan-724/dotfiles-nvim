-- n, v, i, t = mode names

local M = {}

M.general = {
  i = {
    -- go to  beginning and end
    ["<C-b>"] = { "<ESC>^i", "Beginning of line" },
    ["<C-e>"] = { "<End>", "End of line" },

    -- navigate within insert mode
    ["<C-h>"] = { "<Left>", "Move left" },
    ["<C-l>"] = { "<Right>", "Move right" },
    ["<C-j>"] = { "<Down>", "Move down" },
    ["<C-k>"] = { "<Up>", "Move up" },
  },

  n = {
    ["<leader>nd"] = {
      "<cmd> NoiceDismiss <CR>",
      "Dismiss Noice notifications",
    },

    -- close buff
    ["<leader>x"] = {
      function()
        require("apika.tabline.tabline").close_buffer(vim.api.nvim_get_current_buf())
      end,
      "Close buffer",
    },

    ["<Esc>"] = { "<cmd> noh <CR>", "Clear highlights" },
    -- switch between windows
    ["<C-h>"] = { "<C-w>h", "Window left" },
    ["<C-l>"] = { "<C-w>l", "Window right" },
    ["<C-j>"] = { "<C-w>j", "Window down" },
    ["<C-k>"] = { "<C-w>k", "Window up" },

    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- line numbers
    -- ["<leader>n"] = { "<cmd> set nu! <CR>", "Toggle line number" },
    ["<leader>rn"] = { "<cmd> set rnu! <CR>", "Toggle relative number" },

    -- Allow moving the cursor through wrapped lines with j, k, <Up> and <Down>
    -- http://www.reddit.com/r/vim/comments/2k4cbr/problem_with_gj_and_gk/
    -- empty mode is same as using <cmd> :map
    -- also don't use g[j|k] when in operator pending mode, so it doesn't alter d, y or c behaviour
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },

    -- new buffer
    ["<leader>b"] = { "<cmd> enew <CR>", "New buffer" },
    ["<leader>ch"] = { "<cmd> NvCheatsheet <CR>", "Mapping cheatsheet" },

    [";"] = { ":", "Enter command mode", opts = { nowait = true } },
    ["gr"] = {
      function()
        vim.cmd "Telescope lsp_references"
      end,
      "Go to references",
    },

    ["gd"] = {
      function()
        vim.cmd "Telescope lsp_definitions"
      end,
      "Go to definitions",
    },

    ["<leader>q"] = {
      function()
        vim.cmd "Telescope diagnostics"
      end,
      "Go to definitions",
    },

    ["<leader>cd"] = {
      function()
        vim.cmd "Telescope zoxide list"
      end,
      "Go to definitions",
    },

    ["<leader>fm"] = {
      function()
        require("apika.fmt").run()
      end,
      "lsp formatting",
    },
  },

  t = {
    ["<C-x>"] = { vim.api.nvim_replace_termcodes("<C-\\><C-N>", true, true, true), "Escape terminal mode" },
  },

  v = {
    ["<Up>"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    ["<Down>"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["<"] = { "<gv", "Indent line" },
    [">"] = { ">gv", "Indent line" },
  },

  x = {
    ["j"] = { 'v:count || mode(1)[0:1] == "no" ? "j" : "gj"', "Move down", opts = { expr = true } },
    ["k"] = { 'v:count || mode(1)[0:1] == "no" ? "k" : "gk"', "Move up", opts = { expr = true } },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
  },
}

M.tabufline = {
  n = {
    -- cycle through buffers
    ["<tab>"] = {
      function()
        require("apika.tabline.tabline").tabuflineNext()
      end,
      "Goto next buffer",
    },

    ["<S-tab>"] = {
      function()
        require("apika.tabline.tabline").tabuflinePrev()
      end,
      "Goto prev buffer",
    },

    -- cycle through buffers
    ["<leader>h"] = {
      "<Cmd>tabnext<CR>",
      "Goto next tab",
    },

    ["<leader>l"] = {
      "<Cmd>tabprev<CR>",
      "Goto next tab",
    },
  },
}

M.lspconfig = {
  -- See `<cmd> :help vim.lsp.*` for documentation on any of the below functions
  n = {
    ["gD"] = {
      function()
        vim.lsp.buf.declaration()
      end,
      "LSP declaration",
    },

    ["gd"] = {
      function()
        -- vim.lsp.buf.definition()
        vim.cmd "Lspsaga peek_definition"
      end,
      "LSP definition",
    },

    -- ["K"] = {
    --   function()
    --     vim.lsp.buf.hover()
    --   end,
    --   "LSP hover",
    -- },

    ["gi"] = {
      function()
        vim.lsp.buf.implementation()
      end,
      "LSP implementation",
    },

    ["<leader>ls"] = {
      function()
        vim.lsp.buf.signature_help()
      end,
      "LSP signature help",
    },

    ["<leader>D"] = {
      function()
        -- vim.lsp.buf.type_definition()
        vim.cmd "Lspsaga peek_type_definition"
      end,
      "LSP definition type",
    },

    ["<leader>ra"] = {
      function()
        -- require("apika.renamer").open()
        vim.cmd "Lspsaga rename"
      end,
      "LSP rename",
    },

    ["<leader>ca"] = {
      function()
        -- vim.lsp.buf.code_action()
        require("actions-preview").code_actions()
        -- vim.cmd "Lspsaga code_action"
      end,
      "LSP code action",
    },

    -- NOTE: Use Telescope instead
    --
    -- ["gr"] = {
    --   function()
    --     vim.lsp.buf.references()
    --   end,
    --   "LSP references",
    -- },

    ["<leader>lf"] = {
      function()
        vim.diagnostic.open_float { border = "rounded" }
      end,
      "Floating diagnostic",
    },

    ["[d"] = {
      function()
        vim.diagnostic.goto_prev { float = { border = "rounded" } }
      end,
      "Goto prev",
    },

    ["]d"] = {
      function()
        vim.diagnostic.goto_next { float = { border = "rounded" } }
      end,
      "Goto next",
    },

    -- NOTE: Use Telescope instead
    --
    -- ["<leader>q"] = {
    --   function()
    --     vim.diagnostic.setloclist()
    --   end,
    --   "Diagnostic setloclist",
    -- },

    ["<leader>wa"] = {
      function()
        vim.lsp.buf.add_workspace_folder()
      end,
      "Add workspace folder",
    },

    ["<leader>wr"] = {
      function()
        vim.lsp.buf.remove_workspace_folder()
      end,
      "Remove workspace folder",
    },

    ["<leader>wl"] = {
      function()
        print(vim.inspect(vim.lsp.buf.list_workspace_folders()))
      end,
      "List workspace folders",
    },
  },

  v = {
    ["<leader>ca"] = {
      function()
        -- vim.lsp.buf.code_action()
        require("actions-preview").code_actions()
        -- vim.cmd "Lspsaga code_action"
      end,
      "LSP code action",
    },
  },
}

M.nvimtree = {

  n = {
    -- toggle
    ["<C-n>"] = { "<cmd> NvimTreeToggle <CR>", "Toggle nvimtree" },

    -- focus
    ["<leader>e"] = { "<cmd> NvimTreeFocus <CR>", "Focus nvimtree" },
  },
}

M.blankline = {

  n = {
    ["<leader>cc"] = {
      function()
        local ok, start = require("indent_blankline.utils").get_current_context(
          vim.g.indent_blankline_context_patterns,
          vim.g.indent_blankline_use_treesitter_scope
        )

        if ok then
          vim.api.nvim_win_set_cursor(vim.api.nvim_get_current_win(), { start, 0 })
          vim.cmd [[normal! _]]
        end
      end,

      "Jump to current context",
    },
  },
}

return function()
  require("apika.utils").set_mapping(M.general)

  require("apika.utils").set_mapping(M.blankline)
  require("apika.utils").set_mapping(M.lspconfig)
  require("apika.utils").set_mapping(M.nvimtree)
  require("apika.utils").set_mapping(M.tabufline)
end
