--Basic settings
local basic_option = {
    relativenumber = true,
    tabstop        = 4,
    softtabstop    = 4,
    shiftwidth     = 4,
    expandtab      = true,
    backup         = false,
    swapfile       = false,
    autowrite      = false
}
for opt, v in pairs(basic_option) do
	vim.opt[opt] = v
end

--Plugins
--  bootstap lazy.nvim
local lazypath = vim.fn.stdpath("data") .. "/lazy/lazy.nvim"
if not (vim.uv or vim.loop).fs_stat(lazypath) then
  vim.fn.system({
    "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", -- latest stable release
    lazypath,
  })
end
vim.opt.rtp:prepend(lazypath)

--  setup plugins
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '
require('lazy').setup('plugins')

--Keymaps
-- normal keybinds
vim.keymap.set('n', '<F1>', '<cmd>NvimTreeToggle<cr>')
--  use which-key
local wk = require('which-key')
wk.register({
    ['<leader>'] = {
        q = { '<cmd>quit<cr>', 'quit neovim' },
        e = {
            name = '+nvim_config',
            e = { '<cmd>e $MYVIMRC<cr>', 'Edit cuurent startup config' },
            p = { function() vim.cmd(string.format('tabnew %s', vim.fn.stdpath('config') .. '/lua/plugins.lua')) end, 'Edit plugins config file' }
        },
        f = {
            name = '+files',
            w = { '<cmd>w<cr>', 'Save current file' },
        },
    }
})
wk.register({
    ['<C-p>'] = {
        f = { '<cmd>FzfLua files<cr>', 'Fuzzy find files' },
        g = { '<cmd>FzfLua live_grep<cr>', 'Fuzzy search file content' }
    }
}, { mode = {'n', 'i'} })

--For test
vim.opt.runtimepath:append('~/test')
require('hello')
