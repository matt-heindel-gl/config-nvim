-- PEP 8 indentation. The global 2-space default in configs/set.lua is a JS/TS
-- convention; Python tooling (ruff, black) assumes 4 and will reformat against it.
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true

-- `<C-s>` globally runs `:Prettier` before writing; vim-prettier has no Python
-- parser, so it errors on every save here. Just write.
vim.keymap.set({ 'n', 'v', 'i', 'x', 's' }, '<C-s>', '<Esc>:w<CR><Esc>',
  { buffer = true, desc = 'save' })
vim.keymap.set({ 'n', 'v', 'i', 'x', 's' }, '<D-s>', '<Esc>:w<CR><Esc>',
  { buffer = true, desc = 'save' })

-- Node types that carry their own brackets. If the cursor sits inside one of
-- these, `%` should behave normally rather than jumping the whole def.
local BRACKETED = {
  argument_list = true,
  dictionary = true,
  dictionary_comprehension = true,
  generator_expression = true,
  interpolation = true,
  list = true,
  list_comprehension = true,
  list_pattern = true,
  parameters = true,
  parenthesized_expression = true,
  set = true,
  set_comprehension = true,
  subscript = true,
  tuple = true,
  tuple_pattern = true,
}

local DEF = { function_definition = true, class_definition = true }

-- Walk up from the cursor. Returns the enclosing def/class node, or nil if a
-- bracketed node is hit first (or there is no enclosing def at all).
local function enclosing_def()
  local ok, node = pcall(vim.treesitter.get_node)
  if not ok or not node then return nil end
  while node do
    local t = node:type()
    if BRACKETED[t] then return nil end
    if DEF[t] then return node end
    node = node:parent()
  end
  return nil
end

-- Python has no closing brace, so `%` has nothing to match on a `def` line.
-- Ping-pong between the def line and the last line of its body instead, falling
-- through to the builtin `%` for anything bracket-delimited or counted (`50%`).
-- Returns keys rather than moving the cursor so the mapping stays usable as a
-- motion (`d%`, `v%`) and stays clear of textlock in expr context.
local function match_def()
  if vim.v.count > 0 then return '%' end

  local node = enclosing_def()
  if not node then return '%' end

  local srow, _, erow, ecol = node:range()
  if ecol == 0 then erow = erow - 1 end

  local cursor = vim.api.nvim_win_get_cursor(0)[1] - 1
  local target = cursor == srow and erow or srow
  return (target + 1) .. 'G'
end

vim.keymap.set({ 'n', 'x', 'o' }, '%', match_def,
  { buffer = true, expr = true, desc = 'match bracket / def bounds' })

-- Let these unwind if the buffer's filetype changes. No spaces around `|` --
-- `unmap` swallows the separator into its lhs and the undo silently no-ops.
local undo = { 'setlocal tabstop<|setlocal softtabstop<|setlocal shiftwidth<|setlocal expandtab<' }
for _, m in ipairs({ 'n', 'x', 'o' }) do
  table.insert(undo, 'silent! ' .. m .. 'unmap <buffer> %')
end
for _, m in ipairs({ 'n', 'v', 'i', 'x', 's' }) do
  table.insert(undo, 'silent! ' .. m .. 'unmap <buffer> <C-s>')
  table.insert(undo, 'silent! ' .. m .. 'unmap <buffer> <D-s>')
end
vim.b.undo_ftplugin = (vim.b.undo_ftplugin or '') .. '|' .. table.concat(undo, '|')
