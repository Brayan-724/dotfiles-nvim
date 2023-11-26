vim.g.clipboard = "unnamedplus"

if vim.fn.has "wsl" == 1 then
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("Yank", { clear = true }),
    callback = function()
      local uv = vim.uv
      local stdin = uv.new_pipe()
      local stdout = uv.new_pipe()
      local stderr = uv.new_pipe()

      local handle = uv.spawn("clip.exe", { stdio = { stdin, stdout, stderr } }, function() end)

      uv.write(stdin, vim.fn.getreg '"')
      uv.shutdown(stdin, function()
        uv.close(handle, function() end)
      end)
    end,
  })
end

vim.filetype.add {
  extension = {
    astro = "astro",
    mdx = "astro",
  },
}
