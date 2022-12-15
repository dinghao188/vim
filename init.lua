--[[
--1. 基础配置
--]]
local basic_opts = {
    encoding       = 'utf8',               --编码
    gcr            = 'a:block-blinkon400', --光标闪烁
    laststatus     = 3,                    --仅当前窗口显示状态栏
    relativenumber = true,                 --显示相对行号
    cursorline     = true,                 --显示当前行位置
    cursorcolumn   = true,                 --显示当前列位置
    hlsearch       = true,                 --高亮搜索
    expandtab      = true,                 --插入模式下使用空格替换Tab
    tabstop        = 4,                    --按下Tab插入4个空格
    shiftwidth     = 4,                    --自动缩进时插入4个空格
    softtabstop    = 4,                    --保留Tab的行为
    autoindent     = true,                 --自动缩进
    incsearch      = true,                 --渐进式搜索
    bs             = 'start,indent,eol',   --增强退格键功能
    wildmenu       = true,                 --命令行补全
    backup         = false,                --关闭自动备份
    swapfile       = false,                --关闭交换文件
    autowrite      = false,                --关闭自动保存
    foldmethod     = 'marker',             --文本折叠方式
    termguicolors  = true,                 --终端颜色增强
}
for opt_n, opt_v in pairs(basic_opts)
do
    vim.opt[opt_n] = opt_v
end

--[[
--2. 常用函数
--]]
--2.1 执行vim的source命令
local function source(file)
    vim.cmd('source ' .. file)
end
--2.2 快捷键映射函数
local set_keymap = vim.api.nvim_set_keymap

--[[
--3. 可能经常用到的一些值
--]]
local EXTRA_CONF_DIR = vim.fn.stdpath('config') .. '/config_files/' --自定义额外配置文件目录

--[[
--4. 插件配置
--]]
--4.1 安装packer.nvim插件管理器
local function ensure_packer()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end
local bootstrap_packer = ensure_packer()
--4.2 使用packer安装其他插件
require('packer').startup(function(use)
  --包管理器自己
  use 'wbthomason/packer.nvim'
  --颜色主题
  use {'dracula/vim', as='dracula'}
  use {'lifepillar/vim-solarized8'}
  --buffer显示插件
  use {'akinsho/bufferline.nvim', tag="v3.*", requires='nvim-tree/nvim-web-devicons'}
  --状态栏增强插件
  use {'vim-airline/vim-airline'}
  --自动补全插件
  use {'neoclide/coc.nvim', branch='release'}
  --fzf
  use 'junegunn/fzf.vim'
  --文本对齐
  use 'godlygeek/tabular'

  --本地
  use '~/.config/nvim/hello'
  if bootstrap_packer then
    require('packer').sync()
  end
end)
--4.3 一些插件的配置
--[color theme
vim.cmd [[colorscheme dracula]]
--vim.cmd [[hi Normal ctermbg=none guibg=none]] --透明背景
--[airline
vim.g.airline_powerline_fonts = 1
--[bufferline
require('bufferline').setup{}
--coc.nvim
source(EXTRA_CONF_DIR .. 'coc.vim')

--[[
--5. 快捷键配置
--]]
set_keymap('n', '<SPACE>c', ':e $MYVIMRC<CR>', {noremap=true})
set_keymap('n', '<TAB>', 'za', {noremap=true})
set_keymap('n', '<C-h>', ':BufferLineCyclePrev<CR>', {noremap=true, silent=true})
set_keymap('n', '<C-l>', ':BufferLineCycleNext<CR>', {noremap=true, silent=true})
--for fzf
set_keymap('n', '<C-p>', '<Cmd>Files<CR>', {noremap=true, silent=true})
set_keymap('n', '<C-p>@', '<Cmd>CocList outline<CR>', {noremap=true, silent=true})
--for coc-explorer
set_keymap('n', '<C-e>', '<Cmd>CocCommand explorer<CR>', {noremap=true})
set_keymap('i', '<C-e>', '<Cmd>CocCommand explorer<CR>', {noremap=true})
