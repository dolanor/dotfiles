set nocompatible

filetype off

let mapleader = ","
set rtp+=$HOME/.vim/bundle/Vundle.vim/
call vundle#begin()

set t_Co=16
Plugin 'VundleVim/Vundle.vim'
Plugin 'mileszs/ack.vim'
Plugin 'Solarized'
"Plugin 'tpope/vim-dispatch'
"Plugin 'tpope/vim-markdown'
Plugin 'tpope/vim-surround'
"Plugin 'tpope/vim-characterize'
"Plugin 'tpope/vim-speeddating'
"Plugin 'tpope/vim-repeat'
"Plugin 'tpope/vim-afterimage'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-vinegar'
Plugin 'tpope/vim-jdaddy'
Plugin 'tpope/vim-abolish'
"Plugin 'itchyny/calendar.vim'
"Plugin 'derekwyatt/vim-fswitch'
"Plugin 'sukima/xmledit'
Plugin 'ctrlp.vim'
Plugin 'fatih/vim-go'
Plugin 'nsf/gocode', {'rtp': 'vim/'}
"Plugin 'dolanor/zeitgeist.vim'
"Plugin 'valloric/YouCompleteMe'
Plugin 'lifepillar/vim-mucomplete'
"Plugin 'majutsushi/tagbar'
Plugin 'jaxbot/semantic-highlight.vim'
"Plugin 'kylef/apiblueprint.vim'
"Plugin 'cespare/vim-toml'
Plugin 'airblade/vim-gitgutter'
Plugin 'nicwest/vim-git-appraise'
"Plugin 'nelstrom/vim-markdown-folding'
"Plugin 'vim-scripts/TaskList.vim'
Plugin 'wakatime/vim-wakatime'
"Plugin 'mbbill/undotree'
"Plugin 'aklt/plantuml-syntax'
"Plugin 'MattesGroeger/vim-bookmarks'

call vundle#end()
filetype plugin indent on

set number
set relativenumber

" Go options
set autowrite
au BufNewFile,BufRead *.go setlocal noexpandtab tabstop=4 shiftwidth=4 
let g:go_fmt_command = "goimports"
"let g:go_metalinter_autosave = 1
"let g:go_auto_type_info = 1
set updatetime=100
let g:go_auto_sameids = 1

" run :GoBuild or :GoTestCompile based on the go file
function! s:build_go_files()
  let l:file = expand('%')
  if l:file =~# '^\f\+_test\.go$'
    call go#cmd#Test(0, 1)
  elseif l:file =~# '^\f\+\.go$'
    call go#cmd#Build(0)
  endif
endfunction

"autocmd FileType go nmap <leader>b :<C-u>call <SID>build_go_files()<CR>
au FileType go nmap <leader>b <Plug>(go-build)
au FileType go nmap <leader>t <Plug>(go-test)
au FileType go nmap <leader>r <Plug>(go-run)
au FileType go nmap <leader>g <Plug>(go-generate)
au FileType go nmap <leader>c <Plug>(go-coverage-toggle)
au FileType go nmap <leader>i <Plug>(go-info)
au FileType go nmap <leader>e <Plug>(go-rename)

let g:go_fmt_command = "goimports"

" Alternate between code and test
autocmd Filetype go command! -bang A call go#alternate#Switch(<bang>0, 'edit')
autocmd Filetype go command! -bang AV call go#alternate#Switch(<bang>0, 'vsplit')
autocmd Filetype go command! -bang AS call go#alternate#Switch(<bang>0, 'split')
autocmd Filetype go command! -bang AT call go#alternate#Switch(<bang>0, 'tabe')

set path+=vendor,$GOPATH/src,/usr/local/go/src

" mucomplete
set completeopt+=menuone
set completeopt+=noselect
set completeopt+=noinsert
let g:mucomplete#enable_auto_at_startup = 1

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

let g:ackprg = 'pt --smart-case'
cnoreabbrev pt Ack

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



"Markdown folding
"function! MarkdownLevel2()
"    let h = matchstr(getline(v:lnum), '^#\+')
"    if empty(h)
"        return "="
"    else
"        return ">" . len(h)
"    endif
"endfunction
"
"function! MarkdownLevel()
"    if getline(v:lnum) =~ '^# .*$'
"        return ">1"
"    endif
"    if getline(v:lnum) =~ '^## .*$'
"        return ">2"
"    endif
"    if getline(v:lnum) =~ '^### .*$'
"        return ">3"
"    endif
"    if getline(v:lnum) =~ '^#### .*$'
"        return ">4"
"    endif
"    if getline(v:lnum) =~ '^##### .*$'
"        return ">5"
"    endif
"    if getline(v:lnum) =~ '^###### .*$'
"        return ">6"
"    endif
"    return "=" 
"endfunction

"au BufEnter *.md,*.apib setlocal foldexpr=MarkdownLevel
"au BufEnter *.md,*.apib setlocal foldmethod=expr

autocmd FileType gitcommit setlocal spell

" Solarized color for semantic highlight
let g:semanticGUIColors = ['#b58900', '#cb4b16', '#dc322f', '#d33682', '#6c71c4', '#268bd2', '#2aa198', '#859900']

" yaml
autocmd FileType yaml setlocal ts=2 sts=2 sw=2 expandtab
