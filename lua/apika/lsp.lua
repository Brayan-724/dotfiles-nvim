local M = {
  lspconfig = require "lspconfig",
}

function M.on_attach(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  if client.server_capabilities.signatureHelpProvider then
    require("apika.signature").setup(client)
  end

  -- client.server_capabilities.semanticTokensProvider = nil
end

vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspConfig", {}),
  callback = function(args)
    local client = vim.lsp.get_client_by_id(args.data.client_id)
    if client and client.server_capabilities.inlayHintProvider then
      vim.lsp.inlay_hint.enable(args.buf, true)
    end
    -- whatever other lsp config you want
  end,
})

M.capabilities = vim.lsp.protocol.make_client_capabilities()

M.capabilities.textDocument.completion.completionItem = {
  documentationFormat = { "markdown", "plaintext" },
  snippetSupport = true,
  preselectSupport = true,
  insertReplaceSupport = true,
  labelDetailsSupport = true,
  deprecatedSupport = true,
  commitCharactersSupport = true,
  tagSupport = { valueSet = { 1 } },
  resolveSupport = {
    properties = {
      "documentation",
      "detail",
      "additionalTextEdits",
    },
  },
}

--- @param name string
--- @param _opts any
function M.setup(name, _opts)
  _opts = vim.tbl_deep_extend("force", {
    on_attach = M.on_attach,
    capabilities = M.capabilities,
  }, _opts)

  M.lspconfig[name].setup(_opts)
end

M.set_mapping = require("apika.utils").set_mapping
M.keymap = require("apika.utils").keymap

return M
