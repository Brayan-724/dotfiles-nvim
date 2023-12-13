local M = {}

function M.rust()
  vim.cmd "!cargo fmt"
end

function M.astro()
  vim.cmd "!prettier --plugin prettier-plugin-astro --write %"
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

