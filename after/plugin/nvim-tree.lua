-- disable netrw at the very start of your init.lua (strongly advised)
-- commenting out to use netrw with :GBrowse
-- vim.g.loaded_netrw = 1
-- vim.g.loaded_netrwPlugin = 1

-- set termguicolors to enable highlight groups
vim.opt.termguicolors = true

-- display on right side
require("nvim-tree").setup({
  view = {
    side = "right",
    width = 50,
  },
  actions = {
    change_dir = {
      enable = true,
    },
  },
  renderer = {
    group_empty = true,
  },
  filters = {
    dotfiles = false,
  },
})

-- toggle open/closed
vim.keymap.set('n', '<c-n>', ':NvimTreeFindFileToggle<CR>')

