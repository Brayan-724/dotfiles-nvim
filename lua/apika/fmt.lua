local M = {}

local PRETTIER_EXT = {
  "[mc]?[jt]s",
  "json5?",
  "ya?ml",
  "toml",
}

function string.find_any(s, patterns)
  return vim.iter(patterns):any(function(i)
    return s:find(i) ~= nil
  end)
end

function M.is_running_on_prettier()
  local files = vim.fs.find(function(name)
    return (
      (name == "package.json" or name == ".prettierrc")
      or ((name:startswith ".prettierrc" or name:startswith "prettier.config") and name:find_any(PRETTIER_EXT))
    )
  end, { limit = 10, type = "file" })

  return vim.iter(files):any(function(path)
    if path:endswith "package.json" then
      return vim.fn.readblob(path):find "prettier" ~= nil
    else
      return true
    end
  end)
end

function M.rust()
  vim.cmd "!cargo fmt"
end

function M.nix()
  vim.cmd '!alejandra "%"'
end

function M.javascript()
  if M.is_running_on_prettier() then
    vim.notify_once("Using prettier")
    vim.cmd '!prettier --write "%"'
  else
    vim.notify_once("Using deno")
    vim.cmd '!deno fmt "%"'
  end
end

M.javascriptreact = M.javascript

M.typescript = M.javascript
M.typescriptreact = M.javascript

function M.astro()
  vim.cmd '!prettier --plugin prettier-plugin-astro --write "%"'
end

function M.svelte()
  vim.cmd '!prettier --plugin prettier-plugin-svelte --write "%"'
end

function M.run_filetype(filetype)
  if M[filetype] then
    M[filetype]()
  else
    vim.lsp.buf.format { async = true }
  end
end

function M.run()
  M.run_filetype(vim.bo.filetype)
end

return M
