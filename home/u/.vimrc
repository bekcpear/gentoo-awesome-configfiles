"""""""""""""""""""""""""""""""""""""""""
""""" Vundle Configuration Start"""""""""
"""""""""""""""""""""""""""""""""""""""""
set nocompatible              " required
filetype off                  " required
" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()

" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'fatih/vim-go'
Plugin 'gmarik/Vundle.vim'
Plugin 'jnurmine/Zenburn'

Plugin 'tmhedberg/SimpylFold'
let g:SimpylFold_docstring_preview=1

Plugin 'vim-scripts/indentpython.vim'

Bundle 'Valloric/YouCompleteMe'
let g:ycm_python_binary_path = '/usr/bin/python3'
let g:ycm_server_python_interpreter = '/usr/bin/python2.7'

Plugin 'scrooloose/syntastic'
Plugin 'nvie/vim-flake8'
let python_highlight_all=1

Plugin 'scrooloose/nerdtree'
Plugin 'kien/ctrlp.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
set guifont=Sauce\ Code\ Powerline
"set guifont=Anonymous\ Pro
"Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
"let g:powerline_pycmd = 'py3'
"

"Plugin 'chriskempson/base16-vim'
"let base16colorspace=256  " Access colors present in 256 colorspace

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required
syntax on

"""""""""""""""""""""""""""""""""""""""""
""""" Vundle Configuration E n d"""""""""
"""""""""""""""""""""""""""""""""""""""""

" NERDTree 
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif


" Python
au BufNewFile,BufRead *.py
\set tabstop=2
\set softtabstop=2
\set shiftwidth=2
\set textwidth=79
\set expandtab
\set autoindent
\set fileformat=unix
\set foldmethod=indent " Enable folding
\set foldlevel=99

" css
au BufNewFile,BufRead *.css
\set tabstop=2
\set shiftwidth=2
\set expandtab
\set softtabstop=2

" javascript
au BufNewFile,BufRead *.js
\set tabstop=2
\set shiftwidth=2
\set expandtab

au BufNewFile,BufRead *.php
\set tabstop=2
\set softtabstop=2
\set shiftwidth=2
\set expandtab
\set autoindent
\set fileformat=unix


"+++++++++++++++++++++++++++++++++++++++++++++++++++++++
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++
"+ older +++++++++++++++++++++++++++++++++++++++++++++++
"+++++++++++++++++++++++++++++++++++++++++++++++++++++++
set pastetoggle=<F2>
set encoding=utf-8
set termencoding=utf-8  
set fileencodings=utf-8,ucs-bom,gbk,default,latin1 
if has('gui_running')
  set background=dark
  "colorscheme desert
  colorscheme solarized
  let g:solarized_degrade = 0
  "colorscheme molokai
  "colorscheme wombat256
  "colorscheme base16-solar-flare
  "let g:molokai_original = 1
  "let g:rehash256 = 1
  set guioptions-=m " 隐藏菜单栏
  set guioptions-=T " 隐藏工具栏
  set guioptions-=L " 隐藏左侧滚动条
  set guioptions-=r " 隐藏右侧滚动条
  set guioptions-=b " 隐藏底部滚动条
else
  colorscheme molokai
  "colorscheme base16-google-dark
endif

set t_Co=256
set backupdir=~/.vimbak
set ts=2
set sw=2
set expandtab

set autoindent
set smartindent
set cindent

set cursorline

set shiftwidth=2
set cindent

set nu
set foldlevel=100
set ai
set si
set smarttab
set wrap
set lbr
set tw=0
set foldmethod=syntax

" Set to auto read when a file is changed from the outside
set autoread
" No sound on errors.
set noerrorbells
set novisualbell
" Highlight search things
set hlsearch
"smart backspace
set backspace=start,indent,eol

