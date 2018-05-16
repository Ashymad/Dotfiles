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

" Camel/Snake case movement
Plug 'bkad/CamelCaseMotion'

call plug#end()

" Enable CamelCaseMotion
call camelcasemotion#CreateMotionMappings('<leader>')

" Deoplete
let g:deoplete#enable_at_startup = 1
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"
set completeopt+=noinsert

" neosnippet

let g:neosnippet#enable_completed_snippet = 1

"Use 24-bit (true-color) mode in Vim/Neovim when outside tmux.
"If you're using tmux version 2.2 or later, you can remove the outermost $TMUX check and use tmux's 24-bit color support
"(see < http://sunaku.github.io/tmux-24bit-color.html#usage > for more information.)
if (empty($TMUX))
  if (has("nvim"))
    "For Neovim 0.1.3 and 0.1.4 < https://github.com/neovim/neovim/pull/2198 >
    let $NVIM_TUI_ENABLE_TRUE_COLOR=1
  endif
  "For Neovim > 0.1.5 and Vim > patch 7.4.1799 < https://github.com/vim/vim/commit/61be73bb0f965a895bfb064ea3e55476ac175162 >
  "Based on Vim patch 7.4.1770 (`guicolors` option) < https://github.com/vim/vim/commit/8a633e3427b47286869aa4b96f2bfc1fe65b25cd >
  " < https://github.com/neovim/neovim/wiki/Following-HEAD#20160511 >
  if (has("termguicolors"))
    set termguicolors
  endif
endif

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

set hidden

let g:LanguageClient_serverCommands = {
    \ 'javascript': ['javascript-typescript-stdio'],
    \ 'javascript.jsx': ['javascript-typescript-stdio'],
    \ "python": ['pyls'],
    \ }

nnoremap <silent> K :call LanguageClient#textDocument_hover()<CR>
nnoremap <silent> gd :call LanguageClient#textDocument_definition()<CR>
nnoremap <silent> <F2> :call LanguageClient#textDocument_rename()<CR>

let R_latexcmd = ['latexmk','-pdf','-pdflatex="xelatex -synctex=1 -interaction=nonstopmode"'] 

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
