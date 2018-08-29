set nocompatible

filetype off

let mapleader = ","
set rtp+=$HOME/.vim/bundle/Vundle.vim/
call vundle#begin()

set t_Co=16
Plugin 'VundleVim/Vundle.vim'
Plugin 'Solarized'
Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
Plugin 'tpope/vim-characterize'
Plugin 'tpope/vim-speeddating'
Plugin 'tpope/vim-repeat'
Plugin 'tpope/vim-afterimage'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-jdaddy'
Plugin 'tpope/vim-abolish'
"Plugin 'itchyny/calendar.vim'
"Plugin 'derekwyatt/vim-fswitch'
"Plugin 'sukima/xmledit'
Plugin 'ctrlp.vim'
Plugin 'fatih/vim-go'
"Plugin 'dolanor/zeitgeist.vim'
"Plugin 'valloric/YouCompleteMe'
Plugin 'lifepillar/vim-mucomplete'
"Plugin 'majutsushi/tagbar'
Plugin 'jaxbot/semantic-highlight.vim'
"Plugin 'kylef/apiblueprint.vim'
"Plugin 'cespare/vim-toml'
Plugin 'airblade/vim-gitgutter'
Plugin 'wakatime/vim-wakatime'
Plugin 'nicwest/vim-git-appraise'

call vundle#end()
filetype plugin indent on

au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>e <Plug>(go-rename)
au FileType go nmap <leader>c <Plug>(go-coverage)
au FileType go nmap <leader>t <Plug>(go-test)

let g:go_fmt_command = "goimports"

set path+=$GOPATH/src

let g:calendar_google_calendar = 1

set wildmenu
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

highlight NonStandardWhitespace ctermbg=red guibg=red
match NonStandardWhitespace /[ ]/

set hls
set mouse=a

let g:xml_syntax_folding=1
au FileType xml setlocal foldmethod=syntax


"---------------- FSwitch locations -------------------
let g:fsnonewfiles=1
au BufEnter *.cpp,*.cxx,*.c let b:fswitchdst = 'hpp,hxx,h' | let b:fswitchlocs = 'reg:|\Csrc\(.*src.*\)\@!|include|'
au BufEnter *.hpp,*.hxx,*.h let b:fswitchdst = 'cpp,cxx,c' | let b:fswitchlocs = 'reg:|\include\(.*include.*\)\@!|src|'


command! -nargs=0 -bar Update if &modified
    \|  if empty(bufname('%'))
    \|      browse confirm write
    \|  else
    \|      confirm write
    \|  endif
    \|endif


nnoremap <silent> <C-s> :<C-u>Update<CR>
inoremap <silent> <C-s> <Esc>:<C-u>Update<CR>i


" xmllint reindent (ubuntu package libxml2-utils)
au FileType xml setlocal equalprg=xmllint\ --format\ --recover\ -\ 2>/dev/null

" vim-mucomplete
set completeopt+=menuone

inoremap <expr> <c-e> mucomplete#popup_exit("\<c-e>")
inoremap <expr> <c-y> mucomplete#popup_exit("\<c-y>")
inoremap <expr>  <cr> mucomplete#popup_exit("\<cr>")

set completeopt+=noselect
"let g:mucomplete#enable_auto_at_startup = 1

