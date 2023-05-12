local lsp = require("lsp-zero").preset({})
local navic = require("nvim-navic")

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({buffer = bufnr})
  navic.attach(client, bufnr)
end)

lsp.setup()

-- Mason Package Index
-- https://mason-registry.dev/registry/list
