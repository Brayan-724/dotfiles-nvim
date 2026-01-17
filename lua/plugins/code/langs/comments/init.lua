-- Most based on: https://github.com/OXY2DEV/markview.nvim

local parser = require "plugins.code.langs.comments.parser"
local renderer = require "plugins.code.langs.comments.render"

---@diagnostic disable-next-line: undefined-field
local cursor_timer = vim.uv.new_timer()

--- @type [integer, integer][]
local ignore_ranges = {}

--- Creates ignore ranges from a list of parsed items.
---@param _ string
---@param items table[]
---@return [ integer, integer ][]
local function create_ignore_range(_, items)
  local _r = {}

  -- Do not parse things inside raw block.
  for _, item in ipairs(items["raw_block"] or {}) do
    table.insert(_r, { item.range.row_start, item.range.row_end })
  end

  ignore_ranges = vim.list_extend(ignore_ranges, _r)
  return _r
end

--- Checks if a node should be ignored.
---@param TSTree TSTree
---@return boolean
local function should_ignore(TSTree)
  local t_start, _, t_stop, _ = TSTree:root():range()

  for _, range in ipairs(ignore_ranges) do
    if t_start >= range[1] and t_stop <= range[2] then
      return true
    end
  end

  return false
end

---@param buf integer
local function render_extmarks(buf)
  if not vim.api.nvim_buf_is_loaded(buf) then
    return
  end

  local buf_ft = vim.b[buf].filetype

  --- @type vim.treesitter.LanguageTree?
  local ts_tree = vim.treesitter.get_parser(buf, buf_ft, { error = false })

  if ts_tree == nil then
    return
  end

  ts_tree:parse(true)

  --- @type plugins.ts.comments.item[]
  local content = {}

  ts_tree:for_each_tree(function(tree, lang_tree)
    lang_tree:parse(true)

    if lang_tree:lang() ~= "comment" or should_ignore(tree) then
      return
    end

    --- @type plugins.ts.comments.item[], plugins.ts.comments.sorted
    local c_content, c_sorted = parser.parse(buf, tree, 0, -1)
    create_ignore_range("comment", c_sorted)

    content = vim.list_extend(content, c_content)
  end)

  renderer.clear(buf)
  renderer.render(buf, content)
end

---@param args vim.api.keyset.create_autocmd.callback_args
---@return function
local function wrap_render_extmarks(args)
  return vim.schedule_wrap(function ()
    render_extmarks(args.buf)
  end)
end

vim.api.nvim_create_autocmd({ "TextChanged", "TextChangedI" }, {
  callback = function(args)
    cursor_timer:stop()
    cursor_timer:start(25, 0, wrap_render_extmarks(args))
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter", "WinResized", "VimResized" }, {
  callback = function(args)
    wrap_render_extmarks(args)()
  end,
})

