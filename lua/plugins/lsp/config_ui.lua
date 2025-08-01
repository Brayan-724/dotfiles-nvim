local function severity(name)
  return vim.diagnostic.severity[string.upper(name)]
end

local function hl(name)
  return "DiagnosticSign" .. name
end

local signs_hl = {
  [severity("Error")] = hl("Error"),
  [severity("Info")] = hl("Info"),
  [severity("Hint")] = hl("Hint"),
  [severity("Warn")] = hl("Warn"),
}

vim.diagnostic.config {
  virtual_text = {
    prefix = "",
  },
  signs = {
    text = {
      [severity("Error")] = "󰅙",
      [severity("Info")] = "󰋼",
      [severity("Hint")] = "󰌵",
      [severity("Warn")] = "",
    },
    numhl = signs_hl,
    texthl = signs_hl,
  },
  underline = true,
  update_in_insert = true,
}

local hl_name = "FloatBorder"
local border = {
  { "╭", hl_name },
  { "─", hl_name },
  { "╮", hl_name },
  { "│", hl_name },
  { "╯", hl_name },
  { "─", hl_name },
  { "╰", hl_name },
  { "│", hl_name },
}

vim.lsp.handlers["textDocument/hover"] = vim.lsp.with(vim.lsp.handlers.hover, {
  border = border,
})
vim.lsp.handlers["textDocument/signatureHelp"] = vim.lsp.with(vim.lsp.handlers.signature_help, {
  border = border,
  focusable = false,
  relative = "cursor",
})

vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  underline = true,
  virtual_text = {
    spacing = 5,
    min = { severity = "Warning" },
  },
  update_in_insert = true,
})

-- Borders for LspInfo window
local win = require "lspconfig.ui.windows"
local _default_opts = win.default_opts

win.default_opts = function(options)
  local opts = _default_opts(options)
  opts.border = border
  return opts
end

-- To instead override globally
local orig_util_open_floating_preview = vim.lsp.util.open_floating_preview
function vim.lsp.util.open_floating_preview(contents, syntax, opts, ...)
  opts = opts or {}
  opts.border = opts.border or border
  return orig_util_open_floating_preview(contents, syntax, opts, ...)
end
