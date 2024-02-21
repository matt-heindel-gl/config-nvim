local cmp = require("cmp")
local cmp_action = require('lsp-zero').cmp_action()

cmp.setup({
  preselect = 'item',
  completion = {
    completeopt = 'menu,menuone,noinsert'
  },
  mapping = {
    ['<CR>'] = cmp.mapping.confirm({select = true}),
  }
})
