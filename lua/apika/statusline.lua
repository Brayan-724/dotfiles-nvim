local fn = vim.fn

local separators = { left = "", right = "" }

local sep_l = separators["left"]
local sep_r = "%#St_sep_r#" .. separators["right"] .. " %#ST_EmptySpace#"

local function gen_block(icon, txt, sep_l_hlgroup, iconHl_group, txt_hl_group)
  return sep_l_hlgroup .. sep_l .. iconHl_group .. icon .. " " .. txt_hl_group .. " " .. txt .. sep_r
end

local function stbufnr()
  return vim.api.nvim_win_get_buf(vim.g.statusline_winid)
end

local function is_activewin()
  return vim.api.nvim_get_current_win() == vim.g.statusline_winid
end

local M = {}

M.modes = {
  ["n"] = { "󰋜", "St_NormalMode" },
  ["no"] = { "󰋜", "St_NormalMode" },
  ["nov"] = { "󰋜", "St_NormalMode" },
  ["noV"] = { "󰋜", "St_NormalMode" },
  ["noCTRL-V"] = { "󰋜", "St_NormalMode" },
  ["niI"] = { "󰋜 i", "St_NormalMode" },
  ["niR"] = { "󰋜 r", "St_NormalMode" },
  ["niV"] = { "󰋜 v", "St_NormalMode" },
  ["nt"] = { "󰋜 ", "St_NTerminalMode" },
  ["ntT"] = { "󰋜 ", "St_NTerminalMode" },

  ["v"] = { "󰈈", "St_VisualMode" },
  ["vs"] = { "󰈈 (Ctrl O)", "St_VisualMode" },
  ["V"] = { "󰈈", "St_VisualMode" },
  ["Vs"] = { "󰈈", "St_VisualMode" },
  -- [""] = { "󰈈", "St_VisualMode" },

  ["i"] = { "󰏫", "St_InsertMode" },
  ["ic"] = { "󰏫", "St_InsertMode" },
  ["ix"] = { "󰏫", "St_InsertMode" },

  ["t"] = { "", "St_TerminalMode" },

  ["R"] = { "", "St_ReplaceMode" },
  ["Rc"] = { " (Rc)", "St_ReplaceMode" },
  ["Rx"] = { "", "St_ReplaceMode" },
  ["Rv"] = { "", "St_ReplaceMode" },
  ["Rvc"] = { "", "St_ReplaceMode" },
  ["Rvx"] = { "", "St_ReplaceMode" },

  ["s"] = { "󰏫", "St_SelectMode" },
  ["S"] = { "󰏫", "St_SelectMode" },
  -- [""] = { "S-BLOCK", "St_SelectMode" },
  ["c"] = { "", "St_CommandMode" },
  ["cv"] = { "", "St_CommandMode" },
  ["ce"] = { "", "St_CommandMode" },
  ["r"] = { "󰛔", "St_ConfirmMode" },
  ["rm"] = { "MORE", "St_ConfirmMode" },
  ["r?"] = { "", "St_ConfirmMode" },
  ["x"] = { "", "St_ConfirmMode" },
  ["!"] = { "", "St_TerminalMode" },
}

M.mode = function()
  if not is_activewin() then
    return ""
  end

  local m = vim.api.nvim_get_mode().mode

  local sep_l_hl = "%#" .. M.modes[m][2] .. "Sep#"
  local icon_hl = "%#" .. M.modes[m][2] .. "#"
  local icon = M.modes[m][1]

  return sep_l_hl .. separators.left .. icon_hl .. icon .. sep_l_hl .. separators.right .. " "

  -- return gen_block(
  --   "",
  --   M.modes[m][1],
  --   "%#" .. M.modes[m][2] .. "Sep#",
  --   "%#" .. M.modes[m][2] .. "#",
  --   "%#" .. M.modes[m][2] .. "Text#"
  -- )
end

M.fileInfo = function()
  local icon = "󰈚"
  local path = vim.api.nvim_buf_get_name(stbufnr())
  local name = (path == "" and "Empty ") or path:match "([^/\\]+)[/\\]*$"

  if name ~= "Empty" then
    local devicons_present, devicons = pcall(require, "nvim-web-devicons")

    if devicons_present then
      local ft_icon = devicons.get_icon(name)
      icon = (ft_icon ~= nil and ft_icon) or icon
    end
  end

  return gen_block(icon, name, "%#St_file_sep#", "%#St_file_bg#", "%#St_file_txt#")
end

M.git = function()
  if not vim.b[stbufnr()].gitsigns_head or vim.b[stbufnr()].gitsigns_git_status then
    return ""
  end

  local git_status = vim.b[stbufnr()].gitsigns_status_dict

  local added = (git_status.added and git_status.added ~= 0) and ("  " .. git_status.added) or ""
  local changed = (git_status.changed and git_status.changed ~= 0) and ("  " .. git_status.changed) or ""
  local removed = (git_status.removed and git_status.removed ~= 0) and ("  " .. git_status.removed) or ""
  local branch_name = " " .. git_status.head

  return "%#St_gitIcons#" .. branch_name .. added .. changed .. removed
end

M.LSP_Diagnostics = function()
  if not rawget(vim, "lsp") then
    return ""
  end

  local errors = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.ERROR })
  local warnings = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.WARN })
  local hints = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.HINT })
  local info = #vim.diagnostic.get(stbufnr(), { severity = vim.diagnostic.severity.INFO })

  errors = (errors and errors > 0) and ("%#St_lspError#" .. " " .. errors .. " ") or ""
  warnings = (warnings and warnings > 0) and ("%#St_lspWarning#" .. "  " .. warnings .. " ") or ""
  hints = (hints and hints > 0) and ("%#St_lspHints#" .. "󰛩 " .. hints .. " ") or ""
  info = (info and info > 0) and ("%#St_lspInfo#" .. "󰋼 " .. info .. " ") or ""

  return errors .. warnings .. hints .. info
end

M.LSP_status = function()
  if rawget(vim, "lsp") then
    for _, client in ipairs(vim.lsp.get_active_clients()) do
      if client.attached_buffers[stbufnr()] and client.name ~= "null-ls" then
        return (vim.o.columns > 100 and gen_block("", client.name, "%#St_lsp_sep#", "%#St_lsp_bg#", "%#St_lsp_txt#"))
          or "  LSP "
      end
    end
  end

  return ""
end

M.cwd = function()
  return (
    vim.o.columns > 85
    and gen_block("", fn.fnamemodify(fn.getcwd(), ":t"), "%#St_cwd_sep#", "%#St_cwd_bg#", "%#St_cwd_txt#")
  ) or ""
end

M.cursor_position = function()
  return gen_block("", "%l/%c", "%#St_Pos_sep#", "%#St_Pos_bg#", "%#St_Pos_txt#")
end

M.file_encoding = function()
  local encode = vim.bo[stbufnr()].fileencoding
  return string.upper(encode) == "" and "" or string.upper(encode) .. "  "
end

M.run = function()
  local modules = {
    M.mode(),
    M.fileInfo(),
    M.git(),

    "%=",
    "%#St_gitIcons#Apika Luca",
    "%=",

    M.file_encoding(),
    M.LSP_Diagnostics(),
    M.LSP_status(),
    M.cwd(),
    M.cursor_position(),
  }

  require "apika.theme.statusline"

  return table.concat(modules)
end

return M
