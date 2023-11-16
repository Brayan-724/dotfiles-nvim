vim.g.clipboard = "unnamedplus"

if vim.fn.has "wsl" == 1 then
  vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("Yank", { clear = true }),
    callback = function()
      local uv = vim.uv
      local stdin = uv.new_pipe()
      local stdout = uv.new_pipe()
      local stderr = uv.new_pipe()

      local handle, pid = uv.spawn("clip.exe", { stdio = { stdin, stdout, stderr } }, function(code, signal) -- on exit
        print("exit code", code)
        print("exit signal", signal)
      end)

      uv.write(stdin, vim.fn.getreg '"')
      uv.shutdown(stdin, function()
        print("stdin shutdown", stdin)
        uv.close(handle, function()
          print("process closed", handle, pid)
        end)
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
