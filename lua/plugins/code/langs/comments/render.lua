local ns = vim.api.nvim_create_namespace "apika/comment"

local renders = {}

---comment
---@param ft string
---@return string, string
local function get_icon(ft)
  local _ft = ft

  if vim.filetype.match { filename = string.format("example.%s", _ft) } then
    _ft = vim.filetype.match { filename = string.format("example.%s", _ft) }
  end

  local devicons = require "nvim-web-devicons"

  return devicons.get_icon_by_filetype(_ft, { default = true })
end

---@param buf integer
---@param line integer
---@param col integer
---@param opts vim.api.keyset.set_extmark
---@return integer
local function extmark(buf, line, col, opts)
  return vim.api.nvim_buf_set_extmark(buf, ns, line, col, opts)
end

---@param buf integer
---@param line integer
---@param col integer
---@param len integer
---@param conceal string
---@param opts vim.api.keyset.set_extmark?
---@return integer
local function conceal_range(buf, line, col, len, conceal, opts)
  opts = opts or {}
  opts.end_col = col + len
  opts.conceal = conceal
  return extmark(buf, line, col, opts)
end

---@param buf integer
---@param line integer
---@param col integer
---@param virt_text [string, string][]
---@param opts vim.api.keyset.set_extmark?
---@return integer
local function add_virt_text(buf, line, col, virt_text, opts)
  opts = opts or {}
  opts.virt_text_pos = opts.virt_text_pos or "inline"
  opts.virt_text = virt_text
  return extmark(buf, line, col, opts)
end

---@param buf integer
---@param item plugins.ts.comments.bold
function renders.bold(buf, item)
  local range = item.range

  conceal_range(buf, range.row_start, range.col_start, 2, "")
  conceal_range(buf, range.row_start, range.col_end - 2, 2, "")
end

function renders.italic(buf, item)
  local range = item.range

  conceal_range(buf, range.row_start, range.col_start, 1, "")
  conceal_range(buf, range.row_start, range.col_end - 1, 1, "")
end

function renders.inline_code(buf, item)
  local range = item.range
  local opts = { hl_group = "@extmark.comment.code" }

  conceal_range(buf, range.row_start, range.col_start, 1, " ", opts)
  conceal_range(buf, range.row_start, range.col_end - 1, 1, " ", opts)
end

---@param buf integer
---@param item plugins.ts.comments.mention
function renders.mention(buf, item)
  local range = item.range

  extmark(buf, range.row_start, range.col_start, {
    end_col = range.col_end,
    hl_group = "@extmark.comment.mention",
  })

  if item.text:sub(1, 1) == "@" then
    add_virt_text(buf, range.row_start, range.col_start, { { " ", "@extmark.comment.mention" } }, {
      virt_text_pos = "inline",
      hl_mode = "combine",
    })
    add_virt_text(buf, range.row_start, range.col_start, { { " ", "@extmark.comment.mention" } }, {
      virt_text_pos = "overlay",
      hl_mode = "combine",
    })
  else
    add_virt_text(buf, range.row_start, range.col_start, { { " ", "@extmark.comment.mention" } }, {
      hl_mode = "combine",
    })
  end
end

---@param buf integer
---@param item plugins.ts.comments.mention
function renders.issue(buf, item)
  local range = item.range

  extmark(buf, range.row_start, range.col_start, {
    end_col = range.col_end,
    hl_group = "@extmark.comment.issue",
  })

  if item.text:sub(1, 1) == "#" then
    add_virt_text(buf, range.row_start, range.col_start, { { " ", "@extmark.comment.issue" } }, {
      virt_text_pos = "inline",
      hl_mode = "combine",
    })
    add_virt_text(buf, range.row_start, range.col_start, { { " ", "@extmark.comment.issue" } }, {
      virt_text_pos = "overlay",
      hl_mode = "combine",
    })
  else
    add_virt_text(buf, range.row_start, range.col_start, { { " ", "@extmark.comment.issue" } }, {
      hl_mode = "combine",
    })
  end
end

local task_icons = {
  note = "󰌵 ",
  warning = " ",
  todo = " ",
  error = "󰅙 ",
  bug = " ",
  hack = " ",
  perf = " ",
}

local task_kind = {
  praise = "note",
  suggestion = "note",
  thought = "note",
  note = "note",
  info = "note",
  XXX = "note",
  ["BREAKING CHANGE"] = "note",

  nitpick = "warning",
  warning = "warning",
  fix = "warning",

  todo = "todo",
  typo = "todo",
  wip = "todo",

  issue = "error",
  error = "error",
  deprecated = "error",

  hack = "hack",
  fixme = "bug",
  perf = "perf",
}

---@param buf integer
---@param item plugins.ts.comments.task
function renders.task(buf, item)
  local range = item.range

  local kind = task_kind[item.kind:lower()]
  if kind == nil then
    return
  end

  local icon = task_icons[kind]
  local hl = "@extmark.comment.task."
  local hl_kind = hl .. kind

  add_virt_text(buf, range.row_start, range.col_start, {
    { "◖", hl .. "border" },
    { icon, hl_kind },
  })
  extmark(buf, range.row_start, range.col_start, {
    end_col = range.label_col_end,
    hl_group = hl_kind,
  })
  add_virt_text(buf, range.row_start, range.label_col_end - 1, { { "◗", hl .. "border" } }, {
    virt_text_pos = "overlay",
  })

  local has_scope = range.col_start + #item.kind == range.label_col_end - 1

  if not has_scope then
    conceal_range(buf, range.row_start, range.col_start + #item.kind, 1, " ", { hl_group = hl_kind })
    conceal_range(buf, range.row_start, range.label_col_end - 2, 1, " ", { hl_group = hl_kind })
  end
end

---@param buf integer
---@param item plugins.ts.comments.code_block
function renders.code_block(buf, item)
  local range = item.range

  local backticks_end_col = range.col_start + #(item.text[1] or "")
  local lang = item.language or ""

  local max_line_width = 0

  for _, t in pairs(item.text) do
    max_line_width = item.range.col_start + math.max(max_line_width, vim.fn.strdisplaywidth(t))
  end

  max_line_width = max_line_width + 2

  local win_width = vim.api.nvim_win_get_width(0) - 6
  local block_width = math.min(math.max(max_line_width, 60), win_width)
  local code_width = block_width

  if max_line_width >= win_width then
    local line_wraps = math.ceil(max_line_width / win_width)
    code_width = line_wraps * win_width
  end

  ---@param range_start integer
  ---@param range_end integer
  ---@param text [string, string][]
  local function overlay_conceal(range_row, range_start, range_end, text)
    local range_offset = range_start
    ---@type [ string, string ]
    local selected_chunk = table.remove(text)

    for i = range_start, range_end - 1 do
      if i - range_offset >= #selected_chunk[1] then
        selected_chunk = table.remove(text)
        range_offset = i
      end

      conceal_range(buf, range_row, i, 1, selected_chunk[1]:sub(i - range_offset + 1), {
        hl_group = selected_chunk[2],
        hl_mode = "combine",
      })
    end
  end

  if lang ~= "" then
    local icon, icon_hl = get_icon(lang)

    extmark(buf, range.row_start, range.col_start, {
      end_col = backticks_end_col,
      virt_text_pos = "overlay",
      virt_text = {
        { " " .. icon .. " ", icon_hl },
      },
      hl_group = "@extmark.comment.code.label",
      hl_mode = "combine",
    })

    extmark(buf, range.row_start, backticks_end_col, {
      virt_text_pos = "inline",
      virt_text = {
        { " ", "@extmark.comment.code.label" },
      },
    })
  else
    overlay_conceal(range.row_start, range.col_start, backticks_end_col, {
      { string.rep(" ", backticks_end_col), "@extmark.comment.code" },
    })

    extmark(buf, range.row_start, backticks_end_col, {
      virt_text_pos = "inline",
      virt_text = {
        { " ", "@extmark.comment.code" },
      },
    })
  end

  extmark(buf, range.row_start, backticks_end_col, {
    virt_text_pos = "overlay",
    virt_text = {
      { string.rep(" ", block_width - vim.fn.strdisplaywidth(lang) - 4), "@extmark.comment.code" },
    },
  })

  for l, line in pairs(item.text) do
    if l == 1 then
      goto continue
    end

    extmark(buf, range.row_start + l - 1, 0, {
      virt_text_pos = "inline",
      virt_text = {
        { "  ", "@extmark.comment.code" },
      },
    })

    if lang == "" then
      extmark(buf, range.row_start + l - 1, 0, {
        end_col = #line,
        hl_group = "@extmark.comment.code",
        hl_mode = "combine",
      })
    end

    extmark(buf, range.row_start + l - 1, #line, {
      virt_text_pos = "overlay",
      virt_text = {
        { string.rep(" ", code_width - vim.fn.strdisplaywidth(line) - 2), "@extmark.comment.code" },
      },
    })

    ::continue::
  end

  -- FOOTER

  overlay_conceal(range.row_end, range.end_delim[2], range.col_end, {
    { string.rep(" ", range.end_delim[4]), "@extmark.comment.code" },
  })

  extmark(buf, range.row_end, range.end_delim[4], {
    virt_text_pos = "inline",
    virt_text = {
      { string.rep(" ", block_width - range.end_delim[4]), "@extmark.comment.code" },
    },
  })

  extmark(buf, range.row_end, 0, {
    virt_text_win_col = block_width - #"@ApikaLuca" - 1,
    virt_text_pos = "overlay",
    virt_text = {
      { "@ApikaLuca", "@extmark.comment.code.author" },
    },
  })
end

---@param buf integer
---@param content plugins.ts.comments.item[]
function renders.render(buf, content)
  for _, node in ipairs(content) do
    local renderer = renders[node.class]

    if renderer == nil then
      vim.notify_once("No renderer for " .. node.class)
    else
      renderer(buf, node)
    end
  end
end

---@param buf integer
function renders.clear(buf)
  vim.api.nvim_buf_clear_namespace(buf, ns, 0, -1)
end

return renders
