local lock_file = vim.fn.stdpath "data" .. "/cmd.lock"

local function load_lock()
  local f = io.open(lock_file, "r")
  if not f then
    return
  end

  local data = f:read "a"
  if type(data) == "string" then
    vim.g.compile_command = data
  end
  f:close()
end

load_lock()

local function save_lock()
  if not vim.g.compile_command then
    return
  end

  local f = io.open(lock_file, "w+")
  if not f then
    return
  end

  local _, err = f:write(vim.g.compile_command)
  if err then
    vim.notify(err, vim.log.levels.ERROR)
  end
  f:close()
end

return {
  "ej-shafran/compile-mode.nvim",
  lazy = false,
  branch = "latest",
  dependencies = {
    "nvim-lua/plenary.nvim",
    { "m00qek/baleia.nvim", tag = "v1.3.0" },
  },

  opts = {
    error_regexp_table = {
      rust = {
        regex = "->\\? \\([^:]\\+\\):\\(\\d\\+\\):\\(\\d\\+\\)",
        filename = 1,
        row = 2,
        col = 3,
      },
    },
  },

  config = function(_, opts)
    require("compile-mode").setup(opts)

    local colors = require "apika.theme.colors"

    require("apika.theme.utils").set_highlights {
      CompileModeError = { underline = false, bold = true },
      CompileModeErrorCol = { fg = colors.green, bg = "NONE", underline = false },
      CompileModeErrorRow = { fg = colors.green, bg = "NONE", underline = false },
      CompileModeInfoFilename = { fg = colors.blue, bg = "NONE", underline = false },
      CompileModeErrorFilename = { fg = colors.red, bg = "NONE", underline = false },
      CompileModeWarningFilename = { fg = colors.yellow, bg = "NONE", underline = false },
    }

    require("apika.utils").keymap {
      n = {
        ["<M-x>"] = { "<CMD>Compile<CR>", "Compile Mode" },
      },
    }

    local nio = require "nio"

    nio.run(function()
      while true do
        nio.sleep(1000)
        save_lock()
      end
    end)
  end,
}
