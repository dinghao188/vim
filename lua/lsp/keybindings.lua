local cmp = require'cmp'
local builtin = require('telescope.builtin')
local set_keymap = vim.keymap.set

set_keymap('n', 'gr', builtin.lsp_references, {})
set_keymap('n', 'gd', builtin.lsp_definitions, {})
set_keymap('n', 'gi', builtin.lsp_implementations, {})
set_keymap('n', 'K', vim.lsp.buf.hover, {})
