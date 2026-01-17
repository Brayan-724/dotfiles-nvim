---@meta

------------------------------------------------------------------------------

--- Tree-sitter node range.
---@class plugins.ts.range
---
---@field row_start integer
---@field row_end integer
---@field col_start integer
---@field col_end integer

------------------------------------------------------------------------------

---@class plugins.ts.comments.bold
---
---@field class "bold"
---
---@field text string
---@field range plugins.ts.range

------------------------------------------------------------------------------

---@class plugins.ts.comments.italic
---
---@field class "italic"
---
---@field text string
---@field range plugins.ts.range

------------------------------------------------------------------------------

---@class plugins.ts.comments.inline_code
---
---@field class "inline_code"
---
---@field text string
---@field range plugins.ts.range

------------------------------------------------------------------------------

---@class plugins.ts.comments.mention
---
---@field class "mention"
---
---@field text string
---@field range plugins.ts.range

------------------------------------------------------------------------------

---@class plugins.ts.comments.code_block
---
---@field class "code_block"
---@field uses_tab boolean Does the code block use tab inside it? Used for switching render style.
---
---@field delimiters [ string, string ] Code block delimiters(```).
---@field language string? Language string(typically after ```).
---@field info_string string? Extra information(typically after the language).
---
---@field text string[]
---@field range plugins.ts.comments.code_block.range


---@class plugins.ts.comments.code_block.range
---
---@field start_delim integer[] Range of the **start** delimiter.
---@field end_delim? integer[] Range of the **end** delimiter.
---
---@field row_start integer
---@field row_end integer
---@field col_start integer
---@field col_end integer
---
---@field language? integer[] Range of the language string.
---@field info_string? integer[] Range of info string.

------------------------------------------------------------------------------

--- A `task`.
---@class plugins.ts.comments.task
---
---@field class "task"
---
---@field kind string Type of task(e.g. `feat`, `TODO` etc.)
---@field text string
---@field range plugins.ts.comments.task.range


---@class plugins.ts.comments.task.range
---
---@field label_row_end? integer End row of a label(A label may be like `foo:`, `bar(topic):`).
---@field label_col_end? integer End column of a label(A label may be like `foo:`, `bar(topic):`).
---
---@field kind integer[] Range of the `task kind`(result of `{ TSNode:range() }`).
---
---@field row_start integer
---@field row_end integer
---@field col_start integer
---@field col_end integer

------------------------------------------------------------------------------

--- A `task` scope.
---@class plugins.ts.comments.task_scope
---
---@field class "task_scope"
---
---@field text string
---@field range plugins.ts.comments.task.range

------------------------------------------------------------------------------

--- @alias plugins.ts.comments.item
--- | plugins.ts.comments.bold
--- | plugins.ts.comments.italic
--- | plugins.ts.comments.inline_code
--- | plugins.ts.comments.mention
--- | plugins.ts.comments.code_block
--- | plugins.ts.comments.task
--- | plugins.ts.comments.task_scope

--- @class plugins.ts.comments.sorted
--- @field bold plugins.ts.comments.bold[]
--- @field italic plugins.ts.comments.italic[]
--- @field inline_code plugins.ts.comments.inline_code[]
--- @field mention plugins.ts.comments.mention[]
--- @field code_block plugins.ts.comments.code_block[]
--- @field task plugins.ts.comments.task[]
--- @field task_scope plugins.ts.comments.task_scope[]
