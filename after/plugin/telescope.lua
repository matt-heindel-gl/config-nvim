-- Fuzzy File Finder
-- https://github.com/nvim-telescope/telescope.nvim#pickers

-- Grep results render as `path:lnum:col:text`. The match text is the bulk of
-- the line, it is already visible in the preview, and on merlin's long paths it
-- shoves the filename off screen. Show `path:lnum` only.
--
-- Display-only override: `ordinal` still resolves to the raw ripgrep line, so
-- typing in the prompt keeps fuzzy-matching against the hidden match text.
local make_entry = require('telescope.make_entry')
local telescope_utils = require('telescope.utils')

local function grep_display(entry)
  local path = telescope_utils.transform_path({ cwd = entry.cwd }, entry.filename)
  local text = entry.lnum and (path .. '   :' .. entry.lnum) or path
  -- Mirrors gen_from_vimgrep's own devicon + highlight handling.
  local display, hl_group, icon = telescope_utils.transform_devicons(entry.filename, text)
  if hl_group then
    return display, { { { 0, #icon }, hl_group } }
  end
  return display
end

-- Built per invocation, not at setup: gen_from_vimgrep captures cwd, which
-- changes with :cd and nvim-tree.
local function grep_opts(extra)
  local opts = vim.tbl_extend('force', { cwd = vim.loop.cwd() }, extra or {})
  local base = make_entry.gen_from_vimgrep(opts)
  opts.entry_maker = function(line)
    local entry = base(line)
    if entry then
      entry.display = grep_display
    end
    return entry
  end
  return opts
end

require('telescope').setup({
  pickers = {
    -- gen_from_quickfix defaults the filename column to a fixed 30, which cuts
    -- merlin paths off well before anything distinguishing. Half the results
    -- pane tracks the window instead, with a floor for narrow splits.
    lsp_references = { fname_width = { 0.5, min = 40 } },
  },
  defaults = {
    -- path_display = { shorten = { len = 3, exclude = { -1, -2 } } },
    layout_strategy = 'vertical',
    layout_config = {
      vertical = {
        width = 0.9,
        height = 0.9,
        preview_height = 0.6,
        prompt_position = 'bottom',
      },
    },
  },
})

local builtin = require('telescope.builtin')

-- ## File Pickers
-- fuzzy file finder
vim.keymap.set('n', '<leader>ff', builtin.find_files, {desc = 'find files'})
-- 0x10 in hexcode
vim.keymap.set('n', '<D-p>', builtin.find_files, {desc = 'find files'})
-- vim.keymap.set('n', '<leader>fr', builtin.find_files, {desc = 'files recently closed'})
vim.keymap.set('n', '<leader>fa', function()
  builtin.find_files({ no_ignore = true, hidden = true })
end, {desc = 'find all files, including ignored and hidden'})
vim.keymap.set('n', '<C-p>', builtin.git_files, {})
-- project search
-- TODO: include gitignored and dot files
vim.keymap.set('n', '<leader>ps', function()
	builtin.grep_string(grep_opts({ search = vim.fn.input("Grep > ") }))
end, {desc = 'project search'})
vim.keymap.set('n', '<leader>rgf', function()
	builtin.live_grep(grep_opts())
end, {desc = 'live grep files'})
vim.keymap.set('n', '<leader>rgo', function()
	builtin.live_grep(grep_opts({ grep_open_files = true }))
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

