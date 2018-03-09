" Install vim-plug if not isntalled
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
  silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
    \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
  autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'sheerun/vim-polyglot'
Plug 'itchyny/lightline.vim'

Plug 'scrooloose/nerdtree'
Plug 'ctrlpvim/ctrlp.vim'

" For Python
Plug 'vim-scripts/indentpython.vim'
Plug 'Vimjas/vim-python-pep8-indent'

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

map <C-n> :NERDTreeToggle<CR>

syntax on
colorscheme onedark
set noshowmode
set nu
