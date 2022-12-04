" 通用设置 {{{
set encoding=utf-8
let mapleader = ' '            "    设置<leader>键为<SPC>
let maplocalleader = '\'
filetype plugin indent on      "    打开基于文件类型的插件和缩进
syntax enable                  "    开启语法高亮
syntax on                      "    允许自定义高亮方案

set gcr=a:block-blinkon400     "    设置光标闪烁
set laststatus=2               "    总是显示状态栏
set showcmd                    "    显示命令信息
set number relativenumber      "    显示行号
set cursorline cursorcolumn    "    高亮当前行列
set hlsearch                   "    高亮显示搜索结果

set expandtab                  "    用空格显示制表符
set tabstop=4                  "    设置编辑时制表符占用4个空格
set shiftwidth=4               "    设置格式化时制表符占用4个空格
set softtabstop=4
set autoindent                 "    自动缩进

set incsearch                  "    开启实时搜索 set noignorecase               "    搜索时大小写敏感
set nocompatible               "    关闭兼容模式
set bs=start,indent,eol        "    设置退格键的行为
set wildmenu                   "    vim命令行模式智能补全

set nobackup                   "    关闭自动备份
set noswapfile                 "    不生成交换文件
set noautowrite                "    关闭自动保存
set foldmethod=marker          "    根据标记折叠代码

colorscheme ron             "    设置颜色主题
set t_Co=256                   "    256色显示
" }}}

" 插件设置 {{{
let plug_dir = fnamemodify($MYVIMRC, ':p:h').'/plug/'
let ext_conf_dir = fnamemodify($MYVIMRC, ':p:h').'/config_files/'
execute 'source' plug_dir . 'plug.vim'

call plug#begin(plug_dir)
Plug 'vim-airline/vim-airline'
"Plug 'vim-airline/vim-airline-themes'
Plug 'scrooloose/nerdtree'
Plug 'bling/vim-bufferline'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'scrooloose/nerdcommenter'
Plug 'joshdick/onedark.vim'
Plug 'dyng/ctrlsf.vim'
Plug 'terryma/vim-multiple-cursors'
"Plug 'ryanoasis/vim-devicons'
call plug#end()

"
" vim-airline
"
let g:airline_powerline_fonts = 0
"let g:airline#extensions#bufferline#enabled = 0
let g:bufferline_echo = 0

"
" NERDTree
"
nnoremap <F2> :NERDTree<CR>

"
" coc.nvim
"
execute 'source' ext_conf_dir . 'coc.vim'

" }}}

" 快捷键设置 {{{
nnoremap <leader>ev :e $MYVIMRC<cr>
nnoremap <leader>lv :source $MYVIMRC<cr>

nnoremap <leader>w :w<cr>
nnoremap <leader>q :q<cr>

nnoremap <TAB> za
nnoremap <leader><TAB> zA

" for ctrlsf
nmap     <C-F>f <Plug>CtrlSFPrompt
vmap     <C-F>f <Plug>CtrlSFVwordPath
vmap     <C-F>F <Plug>CtrlSFVwordExec
nmap     <C-F>n <Plug>CtrlSFCwordPath
nmap     <C-F>p <Plug>CtrlSFPwordPath
nnoremap <C-F>o :CtrlSFOpen<CR>
nnoremap <C-F>t :CtrlSFToggle<CR>
inoremap <C-F>t <Esc>:CtrlSFToggle<CR>

nnoremap <M-Enter> :vsplit term://zsh<cr>a
" }}}

" gui版本专用设置 {{{
if has('gui')
	set guifont=JetBrainsMono_Nerd_Font_Mono:h12:cANSI    "    设置单字符宽度字体(win)
    set guifontwide=黑体:h12:cGB2312            "    设置双字符宽度字体(win)
	"set guifont=Source\ Code\ Pro\ 13           "    设置单字符宽度字体(linux)
    "set guifontwide=文泉译微米黑\ 13            "    设置双字符宽度字体(linux)
    set lines=999 columns=999                   "    最大化窗口
	set guioptions-=T                           "    关闭工具栏
    set guioptions-=m                           "    关闭菜单栏
    "colorscheme atomified                      "    gui主题
    " 触发菜单栏的函数
    function! ToggleMenu()
        if match(&guioptions,'m') == -1
            set guioptions+=m
        else
            set guioptions-=m
        endif
    endfunction
    nnoremap <M-m> :call ToggleMenu()<cr>
endif
" }}}

" windows专用设置 {{{
if has('win32')
    au GUIEnter * simalt ~x                      "   最大化窗口
    set ignorecase                               "   关闭大小写敏感
    "set shell=E:\Git\bin\bash                   "   使用bash代替cmd命令行工具
    "set shellslash                              "   避免字符串转义时出现错误
endif
" }}}
