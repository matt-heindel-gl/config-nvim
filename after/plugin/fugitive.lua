-- Git

-- status
vim.keymap.set("n", "<leader>gs", ":tab G<CR>", {desc = 'status'})

-- blame
vim.keymap.set("n", "<leader>gb", ":G blame<CR>", {desc = 'blame'})

-- browse
vim.keymap.set({"n", "v"}, "<leader>go", ":GBrowse<CR>", {desc = 'open on remote'})

