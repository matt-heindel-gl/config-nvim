-- PEP 8 indentation. The global 2-space default in configs/set.lua is a JS/TS
-- convention; Python tooling (ruff, black) assumes 4 and will reformat against it.
vim.opt_local.tabstop = 4
vim.opt_local.softtabstop = 4
vim.opt_local.shiftwidth = 4
vim.opt_local.expandtab = true

-- `<C-s>` globally runs `:Prettier` before writing; vim-prettier has no Python
-- parser, so it errors on every save here. Just write.
vim.keymap.set({ 'n', 'v', 'i', 'x', 's' }, '<C-s>', '<Esc><Cmd>w<CR>',
  { buffer = true, desc = 'save' })
vim.keymap.set({ 'n', 'v', 'i', 'x', 's' }, '<D-s>', '<Esc><Cmd>w<CR>',
  { buffer = true, desc = 'save' })

-- Node types that carry their own brackets. If the cursor sits inside one of
-- these, `%` should behave normally rather than jumping the whole scope.
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

-- Every construct that opens an indented block, i.e. everything that would be
-- brace-delimited in JS. Clauses are listed separately from their parent
-- statement so `%` on an `elif`/`except` bounces that clause, not the whole chain.
local BLOCK = {
  case_clause = true,
  class_definition = true,
  elif_clause = true,
  else_clause = true,
  except_clause = true,
  finally_clause = true,
  for_statement = true,
  function_definition = true,
  if_statement = true,
  match_statement = true,
  try_statement = true,
  while_statement = true,
  with_statement = true,
}

-- Walk up from the cursor to the innermost block. Returns nil if a bracketed
-- node is hit first (let the builtin `%` have it) or there is no enclosing block.
local function enclosing_block()
  local ok, node = pcall(vim.treesitter.get_node)
  if not ok or not node then return nil end
  while node do
    local t = node:type()
    if BRACKETED[t] then return nil end
    if BLOCK[t] then return node end
    node = node:parent()
  end
  return nil
end

-- Last line of the block's own body. `if` and `try` nodes span their trailing
-- elif/else/except clauses, so prefer the body field to stop where the closing
-- brace would in JS. Clauses without a body field already end in the right place.
local function body_end(node)
  local body = node:field('body')[1] or node:field('consequence')[1] or node
  local _, _, erow, ecol = body:range()
  return ecol == 0 and erow - 1 or erow
end

-- Python closes blocks by dedent, so there is no brace for `%` to match.
-- Ping-pong between the header line and the last line of its body instead,
-- falling through to the builtin `%` for anything bracketed or counted (`50%`).
-- Returns keys rather than moving the cursor so it still works as a motion
-- (`d%`, `v%`) and stays clear of textlock in expr context.
local function match_scope()
  if vim.v.count > 0 then return '%' end

  local node = enclosing_block()
  if not node then return '%' end

  local srow = node:range()
  local cursor = vim.api.nvim_win_get_cursor(0)[1] - 1
  return ((cursor == srow and body_end(node) or srow) + 1) .. 'G'
end

vim.keymap.set({ 'n', 'x', 'o' }, '%', match_scope,
  { buffer = true, expr = true, desc = 'match bracket / block bounds' })

-- Format on write, not on <C-s>. The global <C-s> puts :Prettier inside the
-- mapping, so plain :w skips it; hooking BufWritePre covers :w, :wq, :wa and
-- <C-s> alike. Two passes because `ruff format` does not sort imports and this
-- repo selects isort as a lint rule (`I` in ruff.toml).
--
-- The binary must come from a project .venv: ruff.toml pins
-- required-version ==0.9.10 and any other ruff hard-refuses to run. Packages
-- without their own .venv borrow proposal's, the same fallback
-- scripts/generate-pyright-configs.py uses.
local FALLBACK_VENV = 'services/apps/proposal'

local function ruff_bin(path)
  local dir = vim.fs.root(path, '.venv')
  if not dir then
    local repo = vim.fs.root(path, '.git')
    dir = repo and (repo .. '/' .. FALLBACK_VENV)
  end
  local bin = dir and (dir .. '/.venv/bin/ruff')
  return (bin and vim.uv.fs_stat(bin)) and bin or nil
end

-- nil on any non-zero exit so a syntax error leaves the buffer untouched.
local function ruff(bin, args, input)
  local cmd = { bin }
  vim.list_extend(cmd, args)
  local res = vim.system(cmd, { stdin = input, text = true }):wait()
  return (res.code == 0 and res.stdout ~= '') and res.stdout or nil
end

-- Apply the reformat as individual diff hunks rather than one whole-buffer
-- replace. Untouched regions are never rewritten, so Neovim shifts the cursor
-- and marks by the line delta of the hunks *above* them -- which is what keeps
-- the cursor on the same code when isort inserts a blank line further up.
-- Applied bottom-up so earlier hunk indices stay valid as we go.
local function patch(buf, before, after)
  local hunks = vim.diff(
    table.concat(before, '\n') .. '\n',
    table.concat(after, '\n') .. '\n',
    { result_type = 'indices' }
  )
  for i = #hunks, 1, -1 do
    local start_a, count_a, start_b, count_b = unpack(hunks[i])
    -- count_a == 0 is a pure insertion after line start_a.
    local from = count_a > 0 and start_a - 1 or start_a
    vim.api.nvim_buf_set_lines(buf, from, from + count_a, false,
      vim.list_slice(after, start_b, start_b + count_b - 1))
  end
end

local function format_on_write(buf)
  local path = vim.api.nvim_buf_get_name(buf)
  if path == '' then return end
  local bin = ruff_bin(path)
  if not bin then return end

  local before = vim.api.nvim_buf_get_lines(buf, 0, -1, false)
  local src = table.concat(before, '\n') .. '\n'

  -- --stdin-filename is what lets ruff discover the *package's* config, so
  -- per-service settings like known-first-party still apply.
  local sorted = ruff(bin, { 'check', '--fix-only', '--select', 'I',
    '--stdin-filename', path }, src)
  local out = ruff(bin, { 'format', '--stdin-filename', path }, sorted or src)
  if not out or out == src then return end

  patch(buf, before, vim.split((out:gsub('\n$', '')), '\n'))
end

local fmt_group = 'ruff_format_' .. vim.api.nvim_get_current_buf()
vim.api.nvim_create_autocmd('BufWritePre', {
  group = vim.api.nvim_create_augroup(fmt_group, { clear = true }),
  buffer = 0,
  callback = function(args) format_on_write(args.buf) end,
})

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
table.insert(undo, 'silent! autocmd! ' .. fmt_group)
vim.b.undo_ftplugin = (vim.b.undo_ftplugin or '') .. '|' .. table.concat(undo, '|')
