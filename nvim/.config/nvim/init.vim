call plug#begin('~/.local/share/nvim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'

call plug#end()

let g:lightline = { 
	\ 'colorscheme': 'onedark',
	\ }

syntax on
colorscheme onedark
set noshowmode

