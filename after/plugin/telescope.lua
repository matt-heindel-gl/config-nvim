-- Fuzzy File Finder
-- https://github.com/nvim-telescope/telescope.nvim#pickers
print("telescope setup start")
local harpoon = require('harpoon')
harpoon:setup({})

-- basic telescope configuration
local conf = require("telescope.config").values
local function toggle_telescope(harpoon_files)
    local file_paths = {}
    for _, item in ipairs(harpoon_files.items) do
        table.insert(file_paths, item.value)
    end

    require("telescope.pickers").new({}, {
        prompt_title = "Harpoon",
        finder = require("telescope.finders").new_table({
            results = file_paths,
        }),
        previewer = conf.file_previewer({}),
        sorter = conf.generic_sorter({}),
    }):find()
end

vim.keymap.set("n", "<leader>hl", function() toggle_telescope(harpoon:list()) end,
    { desc = "Open harpoon window" })

local builtin = require('telescope.builtin')

-- ## File Pickers
-- fuzzy file finder
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'find files'})
-- vim.keymap.set('n', '<leader>fr', builtin.find_files, {desc = 'files recently closed'})
vim.keymap.set('n', '<leader>fa', function()
  builtin.find_files({ no_ignore = true, hidden = true })
end, {desc = 'find all files, including ignored and hidden'})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- project search
-- TODO: include gitignored and dot files
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string({ search = vim.fn.input("Grep > ") })
end, {desc = 'project search'})
vim.keymap.set('n', '<leader>rgf', function()
	builtin.live_grep()
end, {desc = 'live grep files'})
vim.keymap.set('n', '<leader>rgo', function()
	builtin.live_grep({ grep_open_files = true })
end, {desc = 'live grep open files only'})

-- ## Vim Pickers
-- spell suggest
vim.keymap.set('n', '<leader>sp', builtin.spell_suggest, {desc = 'spell suggest'})
-- list open buffers
vim.keymap.set('n', '<leader>b', builtin.buffers, {desc = 'buffers'})

-- ## Neovim LSP Pickers
-- list diagnostics
vim.keymap.set('n', '<leader>db', builtin.diagnostics, {desc = 'diagnostics builtin'})
-- search history
vim.keymap.set('n', '<leader>sh', builtin.search_history, {desc = 'search history'})
vim.keymap.set('n', '<leader>rb', builtin.lsp_references, {desc = 'references builtin'})

-- ## Git Pickers
-- diff
vim.keymap.set('n', '<leader>gd', builtin.git_status, {desc = 'diff'})
vim.keymap.set('n', '<leader>gr', builtin.git_branches, {desc = 'branches'})
-- commit history of current file
vim.keymap.set('n', '<leader>gh', builtin.git_bcommits, {desc = 'history'})
-- commit log
vim.keymap.set('n', '<leader>gl', builtin.git_commits, {desc = 'log of commits'})
-- stash list
vim.keymap.set('n', '<leader>gt', builtin.git_stash, {desc = 'stashes'})

print("telescope setup complete")
