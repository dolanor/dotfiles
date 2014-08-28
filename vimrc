set nocompatible

filetype off

set rtp+=$HOME/.vim/bundle/vundle/
call vundle#rc()

set t_Co=16
Bundle 'gmarik/vundle'
Bundle 'Solarized'
Bundle 'tpope/vim-markdown'
Bundle 'tpope/vim-surround'
Bundle 'tpope/vim-characterize'
Bundle 'tpope/vim-speeddating'
Bundle 'tpope/vim-repeat'
Bundle 'tpope/vim-afterimage'
Bundle 'tpope/vim-fugitive'
Bundle 'tpope/vim-vinegar'
Bundle 'itchyny/calendar.vim'
Bundle 'derekwyatt/vim-fswitch'
Bundle 'sukima/xmledit'
Bundle 'dolanor/zeitgeist.vim'
Bundle 'ctrlp.vim'
Bundle 'valloric/YouCompleteMe'

let g:calendar_google_calendar = 1

filetype plugin indent on
set wildmode=list:longest,full

syntax enable
set background=dark
colorscheme solarized

set directory=$HOME/.vim_swap
silent! call mkdir(&directory, "p")

" size of a hard tabstop
set tabstop=4
" size of an "indent"
set shiftwidth=4
" a combination of spaces and tabs are used to simulate tab stops at a width
" other than the (hard)tabstop
set softtabstop=4
" make "tab" insert indents instead of tabs at the beginning of line
set smarttab
" Always use spaces instead of tab characters
set expandtab

" ignore case in search
set ignorecase
" don't ignore case when you type search with some uppercase char
set smartcase

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/

set hls
set mouse=a

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax


"---------------- FSwitch locations -------------------
let g:fsnonewfiles=1
au BufEnter *.cpp,*.cxx,*.c let b:fswitchdst = 'hpp,hxx,h' | let b:fswitchlocs = 'reg:|\Csrc\(.*src.*\)\@!|include|'
au BufEnter *.hpp,*.hxx,*.h let b:fswitchdst = 'cpp,cxx,c' | let b:fswitchlocs = 'reg:|\include\(.*include.*\)\@!|src|'
