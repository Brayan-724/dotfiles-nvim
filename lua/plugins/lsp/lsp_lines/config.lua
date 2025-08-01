return function ()
    require("lsp_lines").setup()
    vim.g.lsp_lines_opts = { only_current_line = true }
end
