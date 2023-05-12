local mark = require("harpoon.mark")
local ui = require("harpoon.ui")

vim.keymap.set("n", "<leader>a", mark.add_file, {desc='harpoon add'})
vim.keymap.set("n", "<leader>h", ui.toggle_quick_menu, {desc='harpoon ls'})

vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, {desc = 'harpoon file 1'})
vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, {desc = 'harpoon file 2'})
vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, {desc = 'harpoon file 3'})
vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, {desc = 'harpoon file 4'})
vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end, {desc = 'harpoon file 5'})
vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) end, {desc = 'harpoon file 6'})

require('harpoon').setup({
  -- set marks specific to each git branch
  mark_branch = true,

  -- menu width
  menu = {
    width = 120,
  }
})

