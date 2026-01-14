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
    ["<leader>G"] = { "80|", "Go to print width (80)" },

    ["<leader>ts"] = { "<cmd>ToggleServer<CR>", "Toggle Server" },
    ["<leader>nd"] = { "<cmd> NoiceDismiss <CR>", "Dismiss Noice notifications" },

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

    -- Move line
    ["<M-j>"] = { '<CMD>m +1<CR>==', "Move line down" },
    ["<M-k>"] = { '<CMD>m -2<CR>==', "Move line up" },

    -- save
    ["<C-s>"] = { "<cmd> w <CR>", "Save file" },

    -- Copy all
    ["<C-c>"] = { "<cmd> %y+ <CR>", "Copy whole file" },

    -- Select all
    ["<C-a>"] = { "ggVG", "Copy whole file" },

    -- line numbers
    ["<leader>nt"] = { "<cmd> set nu! <CR>", "Toggle line number" },
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

    [";"] = { ":", "Enter command mode", opts = { nowait = true } },
    ["gr"] = { "<cmd>Telescope lsp_references<CR>", "Go to references", },
    ["gd"] = { "<cmd>Telescope lsp_definitions<CR>", "Go to definitions", },
    ["<leader>q"] = { "<cmd>Telescope diagnostics<CR>", "Go to diagnostics", },
    ["<leader>cd"] = { "<cmd>Telescope zoxide list<CR>", "Open zoxide list", },

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

    ["<M-j>"] = { ':m \'>+1<CR>gv=gv', "Move line down" },
    ["<M-k>"] = { ':m \'<-2<CR>gv=gv', "Move line up" },
    -- Don't copy the replaced text after pasting in visual mode
    -- https://vim.fandom.com/wiki/Replace_a_word_with_yanked_text#Alternative_mapping_for_paste
    ["p"] = { 'p:let @+=@0<CR>:let @"=@0<CR>', "Dont copy replaced text", opts = { silent = true } },
    ["<C-p>"] = { 'p', "Copy replaced text", opts = { silent = true } },
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
    ["<leader>h"] = { "<Cmd>tabnext<CR>", "Goto next tab"},
    ["<leader>ll"] = { "<Cmd>tabprev<CR>", "Goto next tab"},
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

    ["gd"] = { "<cmd>Lspsaga peek_definition<CR>", "LSP definition" },
    ["K"] = { "<cmd>Lspsaga hover_doc<CR>", "LSP hover" },

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

    ["<leader>D"] = { "<cmd>Lspsaga peek_type_definition<CR>", "LSP definition type" },
    ["<leader>ra"] = { "<cmd>Lspsaga rename<CR>", "LSP rename" },
    ["<leader>ca"] = { "<cmd>Lspsaga code_action<CR>", "LSP code action" },

    -- ["<leader>lf"] = {
    --   function()
    --     vim.diagnostic.open_float { border = "rounded" }
    --   end,
    --   "Floating diagnostic",
    -- },

    ["[d"] = { "<cmd>Lspsaga diagnostic_jump_prev<CR>", "Goto prev" },
    ["]d"] = { "<cmd>Lspsaga diagnostic_jump_next<CR>", "Goto next" },

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
    ["<leader>ca"] = { "<cmd>Lspsaga code_action<CR>", "LSP code action" },
  },
}

return function()
  require("apika.utils").set_mapping(M.general)

  require("apika.utils").set_mapping(M.lspconfig)
  require("apika.utils").set_mapping(M.tabufline)
end
