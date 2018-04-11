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
" Plug 'vim-latex/vim-latex'
Plug 'lervag/vimtex'

" R
Plug 'jalvesaq/Nvim-R'

" Completion
Plug 'Valloric/YouCompleteMe', { 'do': './install.py --clang-completer --system-libclang' }

" Git
Plug 'tpope/vim-fugitive'

call plug#end()

" Disable latexBox in polyglot
let g:polyglot_disabled = ['latex']

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

let g:vimtex_view_method = 'zathura'

let g:vimtex_view_zathura_options = '-x "nvr --servername ' . v:servername . ' +%{line} %{input}"'

map <C-l> :NERDTreeToggle<CR>

let g:ycm_python_binary_path = 'python'

if !exists('g:ycm_semantic_triggers')
let g:ycm_semantic_triggers = {}
endif
let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme

syntax on
colorscheme onedark
set noshowmode
set nu

tnoremap <Esc> <C-\><C-n>
au TermOpen * setlocal nonumber norelativenumber
