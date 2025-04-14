-- wide cursor while editing
vim.opt.guicursor = ""

-- display line numbers
vim.opt.nu = true
-- vim.opt.relativenumber = true

-- display file name
vim.opt.title = true

-- use system clipboard
vim.opt.clipboard = 'unnamed'

-- next search result, cursor centered
vim.keymap.set("n", "n", "nzzzv")
vim.keymap.set("n", "N", "Nzzzv")

-- scroll, cursor centered
vim.keymap.set("n", "<C-d>", "<C-d>zz")
vim.keymap.set("n", "<C-u>", "<C-u>zz")

-- tab width
vim.opt.tabstop = 2
vim.opt.softtabstop = 2
vim.opt.shiftwidth = 2
vim.opt.expandtab = true

vim.opt.smartindent = true

-- disable line wrap
vim.opt.wrap = false

vim.opt.swapfile = false
vim.opt.backup = false
vim.opt.undodir = os.getenv("HOME") .. "/.vim/undodir"
vim.opt.undofile = true

vim.opt.hlsearch = false
vim.opt.incsearch = true

vim.opt.termguicolors = true

-- scrolling buffer
-- vim.opt.scrolloff = 4
vim.opt.signcolumn = "yes"
vim.opt.isfname:append("@-@")

vim.opt.updatetime = 50

-- ruler
vim.opt.colorcolumn = "100"

-- case insensitive by default
vim.api.nvim_command("set ignorecase")

-- spell check
vim.opt.spelllang = 'en_us'
vim.opt.spell = true

-- highlight cursor line
vim.opt.cursorline = true

-- highlight yanked text
vim.api.nvim_create_autocmd('TextYankPost', {
  callback = function()
    vim.highlight.on_yank({ timeout = 200 })
  end,
})
