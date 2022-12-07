--[[
--基础配置
--]]
local basic_opts = {
    encoding = 'utf8', --编码
    gcr = 'a:block-blinkon400', --光标闪烁
    laststatus = 3, --仅当前窗口显示状态栏
    relativenumber = true, --显示相对行号
    cursorline = true, --显示当前行位置
    cursorcolumn = true, --显示当前列位置
    hlsearh=true, --高亮搜索
    expandtab = true, --插入模式下使用空格替换Tab
    tabstop = 4, --按下Tab插入4个空格
    shiftwidth = 4, --自动缩进时插入4个空格
    softtabstop = 4, --保留Tab的行为
    autoindent = true, --自动缩进
    incsearch = true, --渐进式搜索
    bs='start,indent,eol', --增强退格键功能
    wildmenu = true, --命令行补全
    nobackup = true, --关闭自动备份
    noswapfile = true, --关闭交换文件
    noautowrite = true, --关闭自动保存
    foldmethod = 'marker', --文本折叠方式
}
for opt_n, opt_v in pairs(basic_opts)
do
    vim.o[opt_n] = opt_v
end

--[[
--插件配置
--]]
local function source(file)
    vim.cmd('source ' .. file)
end
local set_keymap = vim.api.nvim_set_keymap

local vim_config_dir = vim.fn.fnamemodify(vim.env.MYVIMRC, ':p:h')
local plug_dir =  vim_config_dir .. '/plug/'
local ext_conf_dir = vim_config_dir .. '/config_files/'
source(plug_dir .. 'plug.vim')

local Plug = vim.fn['plug#']
vim.call('plug#begin', plug_dir)
Plug 'vim-airline/vim-airline'
Plug 'bling/vim-bufferline'
Plug ('neoclide/coc.nvim', {branch='release'})
Plug 'scrooloose/nerdcommenter'
Plug 'joshdick/onedark.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'junegunn/fzf.vim'
vim.call('plug#end')

--color theme
vim.cmd('colorscheme onedark')
--vim-ariline
vim.g.airline_powerline_fonts = 0
vim.g.bufferline_echo = 0
--coc.nvim
source(ext_conf_dir .. 'coc.vim')

--[[
--快捷键配置
--]]
set_keymap('n', '<SPACE>c', ':e $MYVIMRC<CR>', {noremap=true})
set_keymap('n', '<TAB>', 'za', {noremap=true})
--for fzf
set_keymap('n', '<C-P>', '<Cmd>Files<CR>', {noremap=true, silent=true})
set_keymap('n', '<SPACE>e', '<Cmd>CocCommand explorer<CR>', {noremap=true})
