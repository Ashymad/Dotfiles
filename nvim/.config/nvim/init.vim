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

" Julia
Plug 'JuliaEditorSupport/julia-vim'

" LaTeX
Plug 'lervag/vimtex'

" R
Plug 'jalvesaq/Nvim-R'

" Completion
Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'autozimu/LanguageClient-neovim', {
    \ 'branch': 'next',
    \ 'do': 'bash install.sh',
    \ }

Plug 'junegunn/fzf'

" Snippets
Plug 'Shougo/neosnippet'
Plug 'Shougo/neosnippet-snippets'

" Git
Plug 'tpope/vim-fugitive'

call plug#end()

" Deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
set completeopt+=noinsert

" neosnippet

let g:neosnippet#enable_completed_snippet = 1

" Disable latexBox in polyglot
let g:polyglot_disabled = ['latex']

let g:lightline = { 
	\ 'colorscheme': 'onedark',
	\ }

filetype plugin on

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

autocmd Filetype tex call SetTeXOptions()
function SetTeXOptions()
	setlocal sw=2
	setlocal textwidth=79
	setlocal iskeyword+=:
	setlocal spell! spelllang=pl
endfunction

let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'

if !exists('g:deoplete#omni#input_patterns')
  let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

map <C-l> :NERDTreeToggle<CR>

" let g:ycm_python_binary_path = 'python'
" 
" if !exists('g:ycm_semantic_triggers')
" 	let g:ycm_semantic_triggers = {}
" endif
" let g:ycm_semantic_triggers.tex = g:vimtex#re#youcompleteme
set hidden

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ "python": ['pyls'],
    \ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

syntax on
colorscheme onedark
set noshowmode
set nu

set tabstop=8
set softtabstop=4
set shiftwidth=4
set noexpandtab

tnoremap <Esc> <C-\><C-n>
au TermOpen * setlocal nonumber norelativenumber
