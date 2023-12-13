local M = {}

--- @param str string
function M.echo(str)
  vim.cmd "redraw"
  vim.api.nvim_echo({ { str, "Bold" } }, true, {})
end

--- @param args table
function M.shell_call(args)
  local output = vim.fn.system(args)
  assert(vim.v.shell_error == 0, "External call failed with error code: " .. vim.v.shell_error .. "\n" .. output)
end

--- @param t1 table
--- @param t2 table
function M.merge(t1, t2)
    for k,v in pairs(t2) do
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

--- @param mappings table
function M.set_mapping(mappings)
  for mode, keybinds in pairs(mappings) do
    for keybind, mapping_info in pairs(keybinds) do
      -- merge default + user opts
      local opts = mapping_info.opts or {}
      opts.desc = mapping_info[2]

      vim.keymap.set(mode, keybind, mapping_info[1], opts)
    end
  end
end

return M
