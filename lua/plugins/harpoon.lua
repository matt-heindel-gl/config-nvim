return {
    {
        "ThePrimeagen/harpoon",
        branch = "harpoon2",
        dependencies = { "nvim-lua/plenary.nvim" },
        init = function()
          print('harpoon setup')
          local harpoon = require('harpoon')
          vim.keymap.set("n", "<leader>ha", function() harpoon:list():add() end, {desc='harpoon add'})
          vim.keymap.set("n", "<leader>hl", function() harpoon.ui:toggle_quick_menu(harpoon:list()) end, {desc='harpoon ls'})
-- TODO: fix breaking changes
-- vim.keymap.set("n", "<leader>1", function() ui.nav_file(1) end, {desc = 'harpoon file 1'})
-- vim.keymap.set("n", "<leader>2", function() ui.nav_file(2) end, {desc = 'harpoon file 2'})
-- vim.keymap.set("n", "<leader>3", function() ui.nav_file(3) end, {desc = 'harpoon file 3'})
-- vim.keymap.set("n", "<leader>4", function() ui.nav_file(4) end, {desc = 'harpoon file 4'})
-- vim.keymap.set("n", "<leader>5", function() ui.nav_file(5) end, {desc = 'harpoon file 5'})
-- vim.keymap.set("n", "<leader>6", function() ui.nav_file(6) end, {desc = 'harpoon file 6'})
        end
    }
}
