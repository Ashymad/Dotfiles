if &shell =~# 'fish$'
    set shell=bash
endif

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
Plug 'PietroPate/vim-tex-conceal'

Plug 'rust-lang/rust.vim'

Plug 'dag/vim-fish'

Plug 'jalvesaq/Nvim-R'

Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }

Plug 'Shougo/neosnippet.vim'
Plug 'Shougo/neosnippet-snippets'

Plug 'paretje/deoplete-notmuch', {'for': 'mail'}

Plug 'tpope/vim-fugitive'

Plug 'chaoren/vim-wordmotion'

Plug 'neovim/nvim-lsp'

Plug 'Shougo/deoplete-lsp'

call plug#end()

" Neosnipet
" Note: It must be "imap" and "smap".  It uses <Plug> mappings.
imap <C-j>     <Plug>(neosnippet_expand_or_jump)
smap <C-j>     <Plug>(neosnippet_expand_or_jump)
xmap <C-j>     <Plug>(neosnippet_expand_target)

" For conceal markers.
if has('conceal')
    set conceallevel=2
    let g:tex_conceal="abdgms"
endif

" lightline
let g:lightline = { 
            \ 'colorscheme': 'onedark',
            \ }

" vimtex
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_quickfix_enabled = 0

" nvim-lsp
lua require'nvim_lsp'.rust_analyzer.setup{}
lua require'nvim_lsp'.texlab.setup{}

autocmd Filetype rust setlocal omnifunc=v:lua.vim.lsp.omnifunc

"NERDTree
map <C-k> :NERDTreeToggle<CR>

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

call deoplete#custom#option('omni_patterns', {
      \ 'tex': g:vimtex#re#deoplete,
      \ 'r': ['[^. *\t]\.\w*', '\h\w*::\w*', '\h\w*\$\w*'],
      \})

call deoplete#custom#option('sources', {
            \ 'notmuch': ['notmuch', 'address', '--format=json', '--deduplicate=address', '*'],
            \})

let g:deoplete#enable_at_startup = 1

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
    setlocal spell! spelllang=en
endfunction

autocmd BufNewFile,BufRead *.none set filetype=mail
