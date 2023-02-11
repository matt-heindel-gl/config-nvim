local lsp = require("lsp-zero")

lsp.preset("recommended")

-- Mason Package Index
-- https://github.com/williamboman/mason.nvim/blob/main/PACKAGES.md#mason-package-index
lsp.ensure_installed({
  'tsserver',
  'eslint',
})

lsp.setup()

