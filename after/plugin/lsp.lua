local lsp = require("lsp-zero").preset({})
local navic = require("nvim-navic")

lsp.on_attach(function(client, bufnr)
  lsp.default_keymaps({
    buffer = bufnr,
    -- override keymaps with lsp-zero's
    preserve_mappings = false
  })
  navic.attach(client, bufnr)
end)

lsp.setup()

-- Mason Package Index
-- https://mason-registry.dev/registry/list
