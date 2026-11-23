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

-- Python. Merlin is a uv monorepo: each service/agent/lib gets its own generated
-- pyrightconfig.json (scripts/generate-pyright-configs.py) listing that package's
-- .venv plus the shared lib/merlin + lib/dist source paths. Root on the nearest
-- one so each package gets its own scoped client; packages without a generated
-- config (services/bdd_tests, services/ops) fall back to the repo-root union config.
lsp.configure('pyright', {
  root_dir = function(fname)
    return vim.fs.root(fname, 'pyrightconfig.json') or vim.fs.root(fname, '.git')
  end,
})

lsp.setup()

-- Rounded hover/signature windows. lsp-zero's own border option routes through
-- vim.lsp.buf.hover({...}), which only accepts opts on nvim 0.11+.
if vim.fn.has('nvim-0.11') == 0 then
  vim.lsp.handlers['textDocument/hover'] =
    vim.lsp.with(vim.lsp.handlers.hover, { border = 'rounded' })
  vim.lsp.handlers['textDocument/signatureHelp'] =
    vim.lsp.with(vim.lsp.handlers.signature_help, { border = 'rounded' })
end

-- Mason Package Index
-- https://mason-registry.dev/registry/list
