local M = {}

---@alias DirIteration fun(): string,string

---@param path string
---@return DirIteration,unknown,unknown
function M.scan_dir(path)
  local dir = vim.uv.fs_scandir(path)

  return M.iterate_dir, dir, path
end

---@param path string
---@return DirIteration,unknown,unknown
function M.scan_dir_nested(path)
  local dir = vim.uv.fs_scandir(path)
  local state = { { dir, path } }

  return M.iterate_dir_nested, state, nil
end

---@param dir unknown
---@param path string
---@return string | nil,string | nil
function M.iterate_dir(dir, path)
  ---@type string, string
  local name, type = vim.uv.fs_scandir_next(dir)

  if name == nil then
    return nil
  end

  local absolute_path = path .. "/" .. name
  return absolute_path, type
end

---@alias DirNestedState string[][]

---@param state DirNestedState
---@return string | nil, string | nil
function M.iterate_dir_nested(state, _)
  local cell = state[#state]

  local file, type = M.iterate_dir(cell[1], cell[2])

  if file == nil then
    table.remove(state, #state)

    if #state == 0 then
      return nil
    end

    return "IGNORE THIS", "IGNORE THIS"
  end

  if type == "file" then
    return file, type
  end

  if type == "directory" then
    local dir = vim.uv.fs_scandir(file)
    table.insert(state, { dir, file })

    return file, type
  end

  vim.notify("Unknown file type: " .. type, vim.log.levels.ERROR)

  return nil
end

--- @param t1 table
--- @param t2 table
function M.merge(t1, t2)
  for k, v in pairs(t2) do
    if type(v) == "table" then
      if type(t1[k] or false) == "table" then
        M.merge(t1[k] or {}, t2[k] or {})
      else
        t1[k] = v
      end
    else
      t1[k] = v
    end
  end
  return t1
end

--- @param highlights table
function M.set_highlights(highlights)
  for k, v in pairs(highlights) do
    vim.api.nvim_set_hl(0, k, v)
  end
end

---@returns Keymap[]
function M.normalize_mapping(mappings)
  local out = {}

  for mode, keybinds in pairs(mappings) do
    for keybind, mapping_info in pairs(keybinds) do
      if keybind == 1 then
        out.master = keybind
        goto continue
      end

      -- merge default + user opts
      local opts = mapping_info.opts or {}
      opts.desc = mapping_info.desc or mapping_info[2]

      local action = mapping_info[1]

      if mapping_info.cmd then
        action = "<cmd>" .. mapping_info.cmd .. " <CR>"
      end

      table.insert(out, {
        mode = mode,
        keybind = keybind,
        action = action,
        opts = opts or {},
      })
    end

    ::continue::
  end

  return out
end

--- @param mappings Keymap[]
function M.set_mappings_normalized(mappings)
  for name, keymap in pairs(mappings) do
    if name == "master" then
      goto continue
    end

    vim.keymap.set(keymap.mode, keymap.keybind, keymap.action, keymap.opts)

    ::continue::
  end
end

--- @param mappings Keymap[]
--- @returns table
function M.keymaps_to_lazy(mappings)
  local out = {}

  for name, keymap in pairs(mappings) do
    if name == "master" then
      goto continue
    end

    local out_keymap = {
      keymap.keybind,
      keymap.action,
      mode = keymap.mode,
      desc = keymap.opts.desc,
    }

    local opts = keymap.opts
    vim.list_extend(out_keymap, opts)

    table.insert(out, out_keymap)
    ::continue::
  end

  return out
end

--- @param mappings table
function M.set_mapping(mappings)
  for mode, keybinds in pairs(mappings) do
    for keybind, mapping_info in pairs(keybinds) do
      -- merge default + user opts
      local opts = mapping_info.opts or {}
      opts.desc = mapping_info.desc or mapping_info[2]

      local action = mapping_info[1]

      if mapping_info.cmd then
        action = "<cmd>" .. mapping_info.cmd .. " <CR>"
      end

      vim.keymap.set(mode, keybind, action, opts)
    end
  end
end

return M
