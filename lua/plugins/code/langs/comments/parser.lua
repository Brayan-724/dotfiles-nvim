local M = {}

--- Queried contents
---@type plugins.ts.comments.item[]
M.content = {}

--- Queried contents, but sorted
---@type plugins.ts.comments.sorted
---@diagnostic disable-next-line: missing-fields
M.sorted = {}

---@param data plugins.ts.comments.item
M.insert = function(data)
  table.insert(M.content, data)

  if not M.sorted[data.class] then
    M.sorted[data.class] = {}
  end

  table.insert(M.sorted[data.class], data)
end

---@param class string
---@return function
local function simple_parser(class)
  return function(_, _, text, range)
    M.insert {
      class = class,

      text = text[1],
      range = range,
    }
  end
end

------------------------------------------------------------------------------

M.bold = simple_parser "bold"
M.italic = simple_parser "italic"
M.inline_code = simple_parser "inline_code"
M.mention = simple_parser "mention"
M.issue = simple_parser "issue"

------------------------------------------------------------------------------

---@param buffer integer
---@param TSNode TSNode
---@param text string[]
---@param range plugins.ts.comments.code_block.range
function M.code_block(buffer, TSNode, text, range)
  local uses_tab = false

  local lang = TSNode:field("language")[1]
  local language

  if lang then
    language = vim.treesitter.get_node_text(lang, buffer, {})
    range.language = { lang:range() }
  end

  for _, line in ipairs(text) do
    if string.match(line, "\t") then
      uses_tab = true
      break
    end
  end

  ---@type TSNode, TSNode?
  local start_delim, end_delim

  for child in TSNode:iter_children() do
    if child:type() == "start_delimiter" then
      start_delim = child
      local delim = vim.treesitter.get_node_text(child, buffer, {})

      range.start_delim = { child:range() }
      range.start_delim[2] = range.start_delim[2] + #string.match(delim, "^%s*")
    elseif child:type() == "end_delimiter" then
      end_delim = child
      local delim = vim.treesitter.get_node_text(child, buffer, {})

      range.end_delim = { child:range() }
      range.end_delim[2] = range.end_delim[2] + #string.match(delim, "^%s*")
    end
  end

  M.insert {
    class = "code_block",
    uses_tab = uses_tab,

    language = language,
    info_string = nil,
    delimiters = {
      start_delim and vim.treesitter.get_node_text(start_delim, buffer) or "",
      end_delim and vim.treesitter.get_node_text(end_delim, buffer) or "",
    },

    text = text,
    range = range,
  }
end

------------------------------------------------------------------------------

---@param buffer integer
---@param TSNode TSNode
---@param text string[]
---@param range plugins.ts.comments.task.range
function M.task(buffer, TSNode, text, range)
  local kind = TSNode:field("type")[1]

  for child in TSNode:iter_children() do
    if child:type() == ":" then
      _, _, range.label_row_end, range.label_col_end = child:range()
    end
  end

  if not kind then
    return
  end

  range.kind = { kind:range() }

  M.insert {
    class = "task",
    kind = vim.treesitter.get_node_text(kind, buffer, {}),

    text = text,
    range = range,
  }
end

------------------------------------------------------------------------------

--- @param buf integer
--- @param tree TSTree
--- @param from integer
--- @param to integer
--- @return plugins.ts.comments.item[], plugins.ts.comments.sorted
function M.parse(buf, tree, from, to)
  ---@diagnostic disable-next-line: missing-fields
  M.content, M.sorted = {}, {}

  ---@type vim.treesitter.Query
  local queries = vim.treesitter.query.parse(
    "comment",
    [[
			(bold) @comment.bold
			(italic) @comment.italic

      (code) @comment.inline_code
      (code_block) @comment.code_block

      (task) @comment.task
      (mention) @comment.mention
      (issue_reference) @comment.issue
    ]]
  )

  for capture_id, capture_node, _, _ in queries:iter_captures(tree:root(), buf, from, to) do
    local capture_name = queries.captures[capture_id]

    if not capture_name:match "^comment%." then
      goto continue
    end

    ---@type string
    local capture_text = vim.treesitter.get_node_text(capture_node, buf)
    local r_start, c_start, r_end, c_end = capture_node:range()

    if capture_text == nil then
      goto continue
    end

    local lines = {}

    for line in capture_text:gmatch "(.-)\n" do
      table.insert(lines, line)
    end

    if #lines == 0 then
      lines = { capture_text }
    end

    capture_name = capture_name:gsub("^comment%.", "")

    local parser = M[capture_name]

    if parser == nil then
      vim.notify_once("No parser for " .. capture_name)
    else
      parser(buf, capture_node, lines, {
        row_start = r_start,
        col_start = c_start,

        row_end = r_end,
        col_end = c_end,
      })
    end

    ::continue::
  end

  return M.content, M.sorted
end

return M
