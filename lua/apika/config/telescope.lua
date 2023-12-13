local M = {}

function M.mappings()
  return {
    n = {
      -- find
      ["<leader>ff"] = { "<cmd> Telescope find_files <CR>", "Find files" },
      ["<leader>fa"] = { "<cmd> Telescope find_files follow=true no_ignore=true hidden=true <CR>", "Find all" },
      ["<leader>fw"] = { "<cmd> Telescope live_grep <CR>", "Live grep" },
      ["<leader>fb"] = { "<cmd> Telescope buffers <CR>", "Find buffers" },
      ["<leader>fh"] = { "<cmd> Telescope help_tags <CR>", "Help page" },
      ["<leader>fo"] = { "<cmd> Telescope oldfiles <CR>", "Find oldfiles" },
      ["<leader>fz"] = { "<cmd> Telescope current_buffer_fuzzy_find <CR>", "Find in current buffer" },

      -- git
      ["<leader>cm"] = { "<cmd> Telescope git_commits <CR>", "Git commits" },
      ["<leader>gt"] = { "<cmd> Telescope git_status <CR>", "Git status" },

      -- pick a hidden term
      ["<leader>pt"] = { "<cmd> Telescope terms <CR>", "Pick hidden term" },

      -- theme switcher
      ["<leader>th"] = { "<cmd> Telescope themes <CR>", "Nvchad themes" },

      ["<leader>ma"] = { "<cmd> Telescope marks <CR>", "telescope bookmarks" },
    },
  }
end

function M.opts()
  return {
    defaults = {
      vimgrep_arguments = {
        "rg",
        "-L",
        "--color=never",
        "--no-heading",
        "--with-filename",
        "--line-number",
        "--column",
        "--smart-case",
      },
      prompt_prefix = "   ",
      selection_caret = "  ",
      entry_prefix = "  ",
      initial_mode = "insert",
      selection_strategy = "reset",
      sorting_strategy = "ascending",
      layout_strategy = "horizontal",
      layout_config = {
        horizontal = {
          prompt_position = "top",
          preview_width = 0.55,
          results_width = 0.8,
        },
        vertical = {
          mirror = false,
        },
        width = 0.87,
        height = 0.80,
        preview_cutoff = 120,
      },
      file_sorter = require("telescope.sorters").get_fuzzy_file,
      file_ignore_patterns = { "node_modules" },
      generic_sorter = require("telescope.sorters").get_generic_fuzzy_sorter,
      path_display = { "truncate" },
      winblend = 0,
      border = {},
      color_devicons = true,
      set_env = { ["COLORTERM"] = "truecolor" }, -- default = nil,
      file_previewer = require("telescope.previewers").vim_buffer_cat.new,
      grep_previewer = require("telescope.previewers").vim_buffer_vimgrep.new,
      qflist_previewer = require("telescope.previewers").vim_buffer_qflist.new,
      -- Developer configurations: Not meant for general override
      buffer_previewer_maker = require("telescope.previewers").buffer_previewer_maker,
      mappings = {
        n = { ["q"] = require("telescope.actions").close },
      },
    },

    extensions_list = { "fzf", "zoxide" },
    extensions = {
      fzf = {
        fuzzy = true,
        override_generic_sorter = true,
        override_file_sorter = true,
        case_mode = "smart_case",
      },
    },
  }
end

return M
