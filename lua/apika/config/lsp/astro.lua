local lsp_utils = require "apika.lsp"

vim.filetype.add({
    extension = {
        astro = "astro"
    }
})

lsp_utils.setup("astro", { })
