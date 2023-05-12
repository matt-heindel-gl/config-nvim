vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>cd', vim.cmd.Ex)

-- move selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append next line to current line preserving cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- search and replace current word
vim.keymap.set("n", "<leader>sr", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = 'search/replace under cursor'})

-- paste and preserve bufer
vim.keymap.set("x", "<leader>pp", [["_dP]], {desc = 'paste without yanking'})

-- yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- format and save
vim.keymap.set({"n", "v", "i"}, "<C-s>", "<Esc>:Prettier<CR>:w<CR>", {desc = 'format and save'})

-- no more shift key for commands
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", ":", ";")
-- center cursor on last position
vim.keymap.set({"n", "v"}, "<C-o>", "<C-o>zz", {desc = 'next pos, center screen'})
vim.keymap.set({"n", "v"}, "<C-i>", "<C-i>zz", {desc = 'last pos, center screen'})
vim.keymap.set('n', '*', '*zz', {desc = 'next occurance, center screen'})
vim.keymap.set('n', '#', '#zz', {desc = 'last occurance, center screen'})

-- enable/disable display inline diagnostics
vim.keymap.set("n", "<leader>dd", ":lua vim.diagnostic.config{virtual_text=false}<CR>", {desc = 'diagnostics disable virtual text'})
vim.keymap.set("n", "<leader>de", ":lua vim.diagnostic.config{virtual_text=true}<CR>", {desc = 'diagnostics enable virtual text'})

