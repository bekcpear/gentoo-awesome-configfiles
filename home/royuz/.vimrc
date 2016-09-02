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
Plugin 'Lokaltog/powerline', {'rtp': 'powerline/bindings/vim/'}
set guifont=Sauce\ Code\ Powerline

" Add all your plugins here (note older versions of Vundle used Bundle instead of Plugin)

" All of your Plugins must be added before the following line
call vundle#end()            " required
filetype plugin indent on    " required

"""""""""""""""""""""""""""""""""""""""""
""""" Vundle Configuration E n d"""""""""
"""""""""""""""""""""""""""""""""""""""""

" NERDTree 
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 0 && !exists("s:std_in") | NERDTree | endif
map <C-n> :NERDTreeToggle<CR>
autocmd bufenter * if (winnr("$") == 1 && exists("b:NERDTree") && b:NERDTree.isTabTree()) | q | endif

" Enable folding
set foldmethod=indent
set foldlevel=99

" Python
au BufNewFile,BufRead *.py
\set tabstop=2
\set softtabstop=2
\set shiftwidth=2
\set textwidth=79
\set expandtab
\set autoindent
\set fileformat=unix

" Others
au BufNewFile,BufRead *.js, *.html, *.css
      \set tabstop=2
      \set softtabstop=2
      \set shiftwidth=2

" older
set encoding=utf-8
set termencoding=utf-8  
set fileencodings=utf-8,ucs-bom,gbk,default,latin1 
if has('gui_running')
  set background=dark
  colorscheme solarized
  "colorscheme molokai
  "let g:molokai_original = 1
  "let g:rehash256 = 1
  set guioptions-=m " 隐藏菜单栏
  set guioptions-=T " 隐藏工具栏
  set guioptions-=L " 隐藏左侧滚动条
  set guioptions-=r " 隐藏右侧滚动条
  set guioptions-=b " 隐藏底部滚动条
else
  colorscheme molokai
endif

set backupdir=~/.vimbak
set ts=2
set expandtab

set autoindent
set smartindent
set cindent
filetype indent on

set cursorline

set shiftwidth=2
set cindent

"php
syntax on
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
" smart backspace
set backspace=start,indent,eol

