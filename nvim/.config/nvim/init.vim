" Install vim-plug if not isntalled
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

" Visuals
Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'

" Syntax highlighting
Plug 'sheerun/vim-polyglot'

" Filesystem
Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

" Python
Plug 'vim-scripts/indentpython.vim'
Plug 'Vimjas/vim-python-pep8-indent'

" LaTeX
Plug 'vim-latex/vim-latex'

" R
Plug 'jalvesaq/Nvim-R'

" Completion
Plug 'Valloric/YouCompleteMe'

call plug#end()

let g:lightline = { 
	\ 'colorscheme': 'onedark',
	\ }

autocmd Filetype python call SetPythonOptions()

function SetPythonOptions()
    setlocal tabstop=4
    setlocal softtabstop=4
    setlocal shiftwidth=4
    setlocal textwidth=79
    setlocal expandtab
    setlocal autoindent
    setlocal fileformat=unix
endfunction

filetype plugin on
autocmd Filetype tex call SetTeXOptions()

function SetTeXOptions()
	setlocal sw=2
	setlocal textwidth=79
	setlocal iskeyword+=:
	setlocal spell! spelllang=pl
endfunction

map <C-l> :NERDTreeToggle<CR>

syntax on
colorscheme onedark
set noshowmode
set nu

tnoremap <Esc> <C-\><C-n>
au TermOpen * setlocal nonumber norelativenumber
