vim.g.mapleader = ' '
vim.keymap.set('n', '<leader>cd', vim.cmd.Ex)

-- move selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append next line to current line preserving cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- paste and preserve bufer
vim.keymap.set("x", "<leader>p", [["_dP]])

-- yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- format and save
vim.keymap.set({"n", "v", "i"}, "<C-s>", "<Esc>:Prettier<CR>:w<CR>")

-- no more shift key for commands
vim.keymap.set("n", ";", ":")
vim.keymap.set("n", ":", ";")
-- center cursor on last position
vim.keymap.set({"n", "v"}, "<C-o>", "<C-o>zz")
vim.keymap.set({"n", "v"}, "<C-i>", "<C-i>zz")

-- scroll half page with cursor reset
-- commenting out in favor of smooth scrolling w/ comfortable-motion.vim
-- vim.keymap.set("n", "<C-d>", "<C-d>zz")
-- vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- enable/disable display inline diagnostics
vim.keymap.set("n", "<leader>dd", ":lua vim.diagnostic.config{virtual_text=false}<CR>")
vim.keymap.set("n", "<leader>de", ":lua vim.diagnostic.config{virtual_text=true}<CR>")

