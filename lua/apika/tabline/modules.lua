local api = vim.api
local fn = vim.fn
local tabufline_config = {
  show_numbers = false,
}

local separators = { left = "", right = "" }

local isBufValid = function(bufnr)
  return vim.api.nvim_buf_is_valid(bufnr) and vim.bo[bufnr].buflisted
end
-------------------------------------------------------- functions ------------------------------------------------------------

local function getNvimTreeWidth()
  for _, win in pairs(api.nvim_tabpage_list_wins(0)) do
    if vim.bo[api.nvim_win_get_buf(win)].ft == "NvimTree" then
      return api.nvim_win_get_width(win) + 1
    end
  end
  return 0
end

local function getBtnsWidth() -- close, theme toggle btn etc
  local width = 6
  if fn.tabpagenr "$" ~= 1 then
    width = width + ((3 * fn.tabpagenr "$") + 2) + 10
    width = not vim.g.TbTabsToggled and 8 or width
  end
  return width
end

local function add_fileInfo(name, bufnr, maxwidth_len)
  -- check for same buffer names under different dirs
  for _, value in ipairs(vim.t.bufs) do
    if isBufValid(value) then
      if name == fn.fnamemodify(api.nvim_buf_get_name(value), ":t") and value ~= bufnr then
        local other = {}
        for match in (vim.fs.normalize(api.nvim_buf_get_name(value)) .. "/"):gmatch("(.-)" .. "/") do
          table.insert(other, match)
        end

        local current = {}
        for match in (vim.fs.normalize(api.nvim_buf_get_name(bufnr)) .. "/"):gmatch("(.-)" .. "/") do
          table.insert(current, match)
        end

        name = current[#current]

        for i = #current - 1, 1, -1 do
          local value_current = current[i]
          local other_current = other[i]

          if value_current ~= other_current then
            if (#current - i) < 2 then
              name = value_current .. "/" .. name
            else
              name = value_current .. "/../" .. name
            end
            break
          end
        end
        break
      end
    end

    -- padding around bufname; 24 = bufame length (icon + filename)
    local padding = (maxwidth_len - #name - 5) / 2
    local maxname_len = 16

    name = (#name > maxname_len and string.sub(name, 1, 14) .. "..") or name

    return string.rep(" ", padding) .. name .. string.rep(" ", padding)
  end
end

local function styleBufferTab(nr, maxname_len)
  local name = (#api.nvim_buf_get_name(nr) ~= 0) and fn.fnamemodify(api.nvim_buf_get_name(nr), ":t") or " No Name "
  name = add_fileInfo(name, nr, maxname_len) .. "%X"

  -- add numbers to each tab in tabufline
  if tabufline_config.show_numbers then
    for index, value in ipairs(vim.t.bufs) do
      if nr == value then
        name = name .. index
        break
      end
    end
  end

  -- color close btn for focused / hidden  buffers
  local sep_right = separators.right
  local sep_left = separators.left
  if nr == api.nvim_get_current_buf() then
    local is_modified = vim.bo[0].modified

    name = (is_modified and "%#TbLineBufOnModified#" or "%#TbLineBufOn#") .. name
    sep_right = (is_modified and "%#TbLineBufOnSepModified#" or "%#TbLineBufOnSep#") .. sep_right
    sep_left = (is_modified and "%#TbLineBufOnSepModified#" or "%#TbLineBufOnSep#") .. sep_left
  else
    local is_modified = vim.bo[nr].modified
    name = (is_modified and "%#TbLineBufOffModified#" or "%#TbLineBufOff#") .. name
    sep_right = (is_modified and "%#TbLineBufOffSepModified#" or "%#TbLineFill#") .. sep_right
    sep_left = (is_modified and "%#TbLineBufOffSepModified#" or "%#TbLineFill#") .. sep_left
  end

  return sep_left .. name .. sep_right
end

---------------------------------------------------------- components ------------------------------------------------------------
local M = {}

M.bufferlist = function()
  local buffers = {} -- buffersults
  local available_space = vim.o.columns - getNvimTreeWidth() - getBtnsWidth()
  local current_buf = api.nvim_get_current_buf()
  local has_current = false -- have we seen current buffer yet?

  local maxname_len = 0

  for _, bufnr in ipairs(vim.t.bufs) do
    if isBufValid(bufnr) then
      local name = (#api.nvim_buf_get_name(bufnr) ~= 0) and fn.fnamemodify(api.nvim_buf_get_name(bufnr), ":t")
        or " No Name "
      local name_len = string.len(name)

      if name_len > maxname_len then
        if name_len <= 24 then
          maxname_len = 24
        else
          maxname_len = name_len
        end
      end
    end
  end

  for _, bufnr in ipairs(vim.t.bufs) do
    if isBufValid(bufnr) then
      if ((#buffers + 1) * maxname_len) > available_space then
        if has_current then
          break
        end

        table.remove(buffers, 1)
      end

      has_current = (bufnr == current_buf and true) or has_current
      table.insert(buffers, styleBufferTab(bufnr, maxname_len))
    end
  end

  vim.g.visibuffers = buffers
  return "%#TblineFill#%=" .. table.concat(buffers, " ") .. "%#TblineFill#%=" -- buffers + empty space
end

vim.g.TbTabsToggled = 0

M.tablist = function()
  local result, number_of_tabs = "", fn.tabpagenr "$"

  if number_of_tabs > 1 then
    for i = 1, number_of_tabs, 1 do
      local is_selected = i == fn.tabpagenr()
      local tab_hl = is_selected and "%#TbLineTabOn#" or "%#TbLineTabOff#"
      local icon = is_selected and "" or ""
      result = result .. (tab_hl .. icon .. " ")
    end

    return result
  end

  return ""
end

M.run = function()
  local modules = {
    M.bufferlist(),
    M.tablist(),
  }

  return table.concat(modules)
end

return M
