" Install vim-plug if not isntalled
if empty(glob('~/.local/share/nvim/site/autoload/plug.vim'))
    silent !curl -fLo ~/.local/share/nvim/site/autoload/plug.vim --create-dirs
                \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
    autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin('~/.local/share/nvim/plugged')

Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'

Plug 'scrooloose/nerdtree'

Plug 'vim-scripts/indentpython.vim'
Plug 'Vimjas/vim-python-pep8-indent'

Plug 'JuliaEditorSupport/julia-vim'

Plug 'lervag/vimtex'

Plug 'rust-lang/rust.vim'

Plug 'OmniSharp/omnisharp-vim'

Plug 'jalvesaq/Nvim-R'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

Plug 'natebosch/vim-lsc'

Plug 'paretje/deoplete-notmuch', {'for': 'mail'}

Plug 'tpope/vim-fugitive'

Plug 'chaoren/vim-wordmotion'

Plug 'vimwiki/vimwiki', { 'branch': 'dev' }

call plug#end()

" Deoplete
inoremap <expr><C-h> deoplete#smart_close_popup()."\<C-h>"
inoremap <expr><BS> deoplete#smart_close_popup()."\<C-h>"

function! s:check_back_space() abort "{{{
    let col = col('.') - 1
    return !col || getline('.')[col - 1]  =~ '\s'
endfunction"}}}
imap <silent><expr> <TAB>
            \ pumvisible() ? "\<C-n>" :
            \ <SID>check_back_space() ? "\<TAB>" :
            \ neosnippet#expandable_or_jumpable() ?
            \ "\<Plug>(neosnippet_expand_or_jump)" :
            \ deoplete#manual_complete()

let g:deoplete#enable_at_startup = 1

" Neosnipet
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)

" For conceal markers.
if has('conceal')
    set conceallevel=2 concealcursor=niv
endif

" lightline
let g:lightline = { 
            \ 'colorscheme': 'onedark',
            \ }

" vimtex
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'

if !exists('g:deoplete#omni#input_patterns')
    let g:deoplete#omni#input_patterns = {}
endif
let g:deoplete#omni#input_patterns.tex = g:vimtex#re#deoplete

" Nvim-R
call deoplete#custom#option('omni_patterns', {
            \ 'r': ['[^. *\t]\.\w*', '\h\w*::\w*', '\h\w*\$\w*'],
            \})

" let R_latexcmd = ['latexmk','-pdf','-pdflatex="lualatex -synctex=1 -interaction=nonstopmode"'] 

" OmniSharp
call deoplete#custom#option('sources', {
            \ 'cs': ['omnisharp'],
            \ })

"NERDTree
map <C-k> :NERDTreeToggle<CR>

" vim-lsc

let g:lsc_server_commands = {
            \ 'javascript': ['javascript-typescript-stdio'],
            \ 'javascript.jsx': ['javascript-typescript-stdio'],
            \ 'python': ['pyls'],
            \ 'julia': ['julia', '--startup-file=no', '--history-file=no', '-e', '
            \     using LanguageServer;
            \     using Pkg;
            \     import StaticLint;
            \     import SymbolServer;
            \     env_path = dirname(Pkg.Types.Context().env.project_file);
            \     debug = false; 
            \     
            \     server = LanguageServer.LanguageServerInstance(stdin, stdout, debug, env_path, "", Dict());
            \     server.runlinter = true;
            \     run(server);
            \ '],
            \ 'c': ['ccls', '--log-file=/tmp/cc.log'],
            \ 'cpp': ['ccls', '--log-file=/tmp/cc.log'],
            \ 'cuda': ['ccls', '--log-file=/tmp/cc.log'],
            \ 'objc': ['ccls', '--log-file=/tmp/cc.log'],
            \ 'rust': ['rls'],
            \ }

let g:lsc_auto_map = v:true
autocmd CompleteDone * silent! pclose

" vimwiki
" Workaround for https://github.com/lervag/vimtex/issues/1354
let g:vimtex_syntax_enabled = 1

" vim settings

set hidden
set lazyredraw
set termguicolors
set noshowmode
set wildmenu
set nu
set mouse=a
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set autoindent

filetype plugin indent on

syntax on

colorscheme onedark

tnoremap <Esc> <C-\><C-n>
au TermOpen * setlocal nonumber norelativenumber

au BufReadPost APKBUILD set syntax=sh noexpandtab

autocmd Filetype python call SetPythonOptions()
function SetPythonOptions()
    setlocal textwidth=79
    setlocal fileformat=unix
endfunction

autocmd Filetype tex call SetTeXOptions()
function SetTeXOptions()
    setlocal sw=2
    setlocal textwidth=79
    setlocal iskeyword+=:
    setlocal spell! spelllang=pl
endfunction
