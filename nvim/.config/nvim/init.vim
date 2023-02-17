if &shell =~# 'fish$'
    set shell=bash
endif

if &compatible
  set nocompatible
endif

autocmd BufNewFile,BufRead *.fish set filetype=fish

autocmd BufNewFile,BufRead Jenkinsfile,*.Jenkinsfile set filetype=groovy

autocmd CompleteDone * silent! pclose

set termguicolors
set hidden
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
set noshowmode
set wildmenu
set nu
set mouse=a
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent
set noea
set inccommand=split
set relativenumber
set pumblend=20

let g:vimsyn_embed = 'L'

filetype plugin indent on

syntax on

nmap ,d :b#<bar>bd#<CR>

tnoremap <Esc> <C-\><C-n>
au TermOpen * setlocal nonumber norelativenumber

" readline bindings for command mode
cnoremap <c-a> <home>
cnoremap <c-e> <end>
cnoremap <c-p> <up>
cnoremap <c-n> <down>
cnoremap <c-b> <left>
cnoremap <c-f> <right>
cnoremap <c-k> <c-\>estrpart(getcmdline(), 0, getcmdpos() - 1)<cr>
cnoremap <A-b> <s-left>
cnoremap <A-f> <s-right>
cnoremap <A-left> <s-left>
cnoremap <A-right> <s-right>
cnoremap <A-backspace> <c-w>

"Cpoy and paste 
inoremap <C-v> <C-r>+
vnoremap <C-c> "+y

lua require('plugins')
