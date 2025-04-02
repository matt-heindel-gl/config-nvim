vim.g.mapleader = ' '

vim.keymap.set('n', '<leader>cd', vim.cmd.Ex)

-- move selected lines up/down
vim.keymap.set("v", "J", ":m '>+1<CR>gv=gv")
vim.keymap.set("v", "K", ":m '<-2<CR>gv=gv")

-- append next line to current line preserving cursor position
vim.keymap.set("n", "J", "mzJ`z")

-- search and replace current word
vim.keymap.set("n", "<leader>srf", [[:%s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = 'search/replace file under cursor'})
vim.keymap.set("n", "<leader>srl", [[:s/\<<C-r><C-w>\>/<C-r><C-w>/gI<Left><Left><Left>]], {desc = 'search/replace line under cursor'})

-- paste and preserve bufer
vim.keymap.set("x", "<leader>pp", [["_dP]], {desc = 'paste without yanking'})

-- yank to system clipboard
vim.keymap.set({"n", "v"}, "<leader>y", [["+y]])
vim.keymap.set("n", "<leader>Y", [["+Y]])

-- format and save
vim.keymap.set({"n", "v", "i", "x", "s"}, "<C-s>", "<Esc>:Prettier<CR>:w<CR><Esc>", {desc = 'format and save'})
-- 0x13 in hexcode
vim.keymap.set({"n", "v", "i", "x", "s"}, "<D-s>", "<Esc>:Prettier<CR>:w<CR><Esc>", {desc = 'format and save'})

-- no more shift key for commands
-- vim.keymap.set("n", ";", ":")
-- vim.keymap.set("n", ":", ";")
-- center cursor on last position
vim.keymap.set({"n", "v"}, "<C-o>", "<C-o>zz", {desc = 'next pos, center screen'})
vim.keymap.set({"n", "v"}, "<C-i>", "<C-i>zz", {desc = 'last pos, center screen'})

vim.keymap.set('n', '*', '*zz', {desc = 'next occurance, center screen'})
vim.keymap.set('n', '#', '#zz', {desc = 'last occurance, center screen'})

-- enable/disable display inline diagnostics
vim.keymap.set("n", "<leader>dd", ":lua vim.diagnostic.config{virtual_text=false}<CR>", {desc = 'diagnostics disable virtual text'})
vim.keymap.set("n", "<leader>de", ":lua vim.diagnostic.config{virtual_text=true}<CR>", {desc = 'diagnostics enable virtual text'})

-- diagnostic
vim.keymap.set("n", "<leader>vca", function() vim.lsp.buf.code_action() end, {desc = 'vim code actions'})

-- spell check
vim.keymap.set({"n", "v"}, "<leader>ss", ":set invspell<CR>", {desc = 'spell check toggle'})

vim.keymap.set({"n", "v"}, "<leader>ww", ":set invwrap invlinebreak<CR>", {desc = 'wrap line toggle'})

-- add line without leaving normal mode
vim.keymap.set('n', '<leader>o', [[:call append(line('.'), '')<CR>]], { silent = true, desc = 'add line without moving'})
-- vim.keymap.set('n', '<leader>O', [[:execute 'normal! P']]:format(vim.api.nvim_replace_termcodes('^', true, false, true)), { expr = false, silent = true, desc = 'add line without moving'})


-- debug line
vim.fn.insertDebugLine = function()
  local word = vim.fn.expand("<cword>")
  vim.cmd("normal! oconsole.log(' >> " .. word .. " ::', " .. word .. ")")
end

vim.keymap.set({'n', 'v'}, "<leader>wl", "<cmd>lua vim.fn.insertDebugLine()<CR>", { silent = true, desc = 'word log' })

-- -- comment line
-- vim.fn.insertCommentLine = function()
--   local word = vim.fn.expand("<cword>")
--   vim.cmd("normal! O\\/ " . word)
--
--   -- execute 'normal! O\\/' . word
-- end
--
-- vim.keymap.set({'n', 'v'}, "<leader>wc", "<cmd>lua vim.fn.insertCommentLine()<CR>", { silent = true, desc = 'word comment' })
-- //'insertCommentLine
-- console.log('insertCommentLine::', insertCommentLine)
--
