local M = {
  lspconfig = require "lspconfig",
}


function M.on_attach(client)
  client.server_capabilities.documentFormattingProvider = false
  client.server_capabilities.documentRangeFormattingProvider = false

  if client.server_capabilities.signatureHelpProvider then
    require("nvchad.signature").setup(client)
  end

  -- client.server_capabilities.semanticTokensProvider = nil
end

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

---@param m table|function
---@return nil
function M.keymap(m)
  if type(m.mappings) ~= "nil" then
    m = m.mappings
  end

  if type(m) == "function" then
    m = m()
  end

  if type(m.mappings) ~= "nil" then
    M.keymap(m.mappings)
    return
  end

  if type(m) == "table" then
    require("apika.utils").set_mapping(m)
  elseif type(m) ~= "nil" then
    M.keymap(m)
  end
end

return M
