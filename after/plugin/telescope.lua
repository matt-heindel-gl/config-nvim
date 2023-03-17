-- Fuzzy File Finder
-- https://github.com/nvim-telescope/telescope.nvim#pickers

local builtin = require('telescope.builtin')

-- ## File Pickers
-- fuzzy file finder
vim.keymap.set('n', '<leader>pf', builtin.find_files, {})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- project search
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end)

-- ## Vim Pickers
-- spell suggest
vim.keymap.set('n', '<leader>sp', builtin.spell_suggest, {})

-- ## Neovim LSP Pickers
-- list diagnostics
vim.keymap.set('n', '<leader>d', builtin.diagnostics, {})
-- search history
vim.keymap.set('n', '<leader>sh', builtin.search_history, {})
vim.keymap.set('n', '<leader>r', builtin.lsp_references, {})

-- ## Git Pickers
-- diff
vim.keymap.set('n', '<leader>gd', builtin.git_status, {})
vim.keymap.set('n', '<leader>gr', builtin.git_branches, {})
-- commit history of current file
vim.keymap.set('n', '<leader>gh', builtin.git_bcommits, {})
-- commit log
vim.keymap.set('n', '<leader>gl', builtin.git_commits, {})
-- stash list
vim.keymap.set('n', '<leader>gt', builtin.git_stash, {})

