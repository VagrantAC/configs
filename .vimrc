call plug#begin()
Plug 'joshdick/onedark.vim'
Plug 'fatih/vim-go', { 'do': ':GoInstallBinaries' }
Plug 'christoomey/vim-system-copy'
Plug 'rip-rip/clang_complete'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'chrisbra/vim-zsh'
Plug 'zsh-users/zsh-syntax-highlighting'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
call plug#end()

syntax on
colorscheme onedark

"设置编码"
set fileencodings=utf-8,ucs-bom,gb18030,gbk,gb2312,cp936
set termencoding=utf-8
set encoding=utf-8

"显示行号"
set nu
set number

"启用鼠标"
set mouse=a
set selection=exclusive
set selectmode=mouse,key

"显示括号匹配"
set showmatch

"设置Tab长度为4空格"
set tabstop=4
"设置自动缩进长度为4空格"
set shiftwidth=4
"继承前一行的缩进方式，适用于多行注释"
set autoindent

set paste

"总是显示状态栏"
set laststatus=2
"显示光标当前位置"
set ruler

"cursorline的缩写形式"
set cursorline
set cul

set hlsearch

let g:airline#extensions#tabline#enabled = 1 
set t_Co=256
let g:airline_powerline_fonts = 1
set laststatus=2
" let g:airline_theme='cool'
let g:airline#extensions#tabline#enabled=1
let g:airline_left_sep = '▶'
let g:airline_left_alt_sep = '❯'
let g:airline_right_sep = '◀'
let g:airline_right_alt_sep = '❮'
hi Normal  ctermfg=252 ctermbg=none


" 设置中文帮助
set helplang=cn


