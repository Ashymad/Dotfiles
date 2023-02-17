if &compatible
  set nocompatible
endif

function! PackInit() abort
  packadd minpac

  call minpac#init()

  call minpac#add('k-takata/minpac', {'type': 'opt', 'branch': 'devel'})

  call minpac#add('vim-scripts/indentpython.vim', {'type': 'opt'})
  call minpac#add('Vimjas/vim-python-pep8-indent', {'type': 'opt'})

  call minpac#add('JuliaEditorSupport/julia-vim', {'type': 'opt'})

  call minpac#add('lervag/vimtex', {'type': 'opt'})
  call minpac#add('PietroPate/vim-tex-conceal', {'type': 'opt'})

  call minpac#add('rust-lang/rust.vim', {'type': 'opt'})

  call minpac#add('ziglang/zig.vim')

  call minpac#add('dag/vim-fish', {'type': 'opt'})

  call minpac#add('jalvesaq/Nvim-R', {'type': 'opt'})

  call minpac#add('mboughaba/i3config.vim', {'type': 'opt'})

  call minpac#add('paretje/deoplete-notmuch', {'type': 'opt'})

  call minpac#add('stephpy/vim-yaml', {'type': 'opt', 'subdir': 'after'})

  call minpac#add('godlygeek/tabular')
  call minpac#add('plasticboy/vim-markdown', {'type': 'opt'})

  call minpac#add('nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'})

  call minpac#add('sonph/onehalf', {'subdir': 'vim'})

  call minpac#add('itchyny/lightline.vim')
  call minpac#add('scrooloose/nerdtree')

  call minpac#add('Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' })

  call minpac#add('tpope/vim-fugitive')

  call minpac#add('chaoren/vim-wordmotion')

  call minpac#add('neovim/nvim-lspconfig')
  call minpac#add('Shougo/deoplete-lsp')

  call minpac#add('folke/lsp-colors.nvim')
  call minpac#add('kyazdani42/nvim-web-devicons')
  call minpac#add('folke/trouble.nvim')
endfunction

command! PackUpdate call PackInit() | call minpac#update()
command! PackClean  call PackInit() | call minpac#clean()
command! PackStatus call PackInit() | call minpac#status()

packloadall

" lightline
let g:lightline = { 
            \ 'colorscheme': 'onehalfdark',
            \ }

" For conceal markers.
if has('conceal')
    set conceallevel=2
    let g:tex_conceal="abdgms"
endif

" vimtex
let g:vimtex_view_method = 'zathura'
let g:vimtex_compiler_progname = 'nvr'
let g:vimtex_quickfix_enabled = 0
let g:vimtex_compiler_latexmk = {
    \ 'options' : [
    \   '-pdf',
    \   '-shell-escape',
    \   '-verbose',
    \   '-file-line-error',
    \   '-synctex=1',
    \   '-interaction=nonstopmode',
    \ ],
    \}

"NERDTree
map <C-k> :NERDTreeToggle<CR>

" nvim-lsp
lua require'lspconfig'.rust_analyzer.setup{}
lua require'lspconfig'.jedi_language_server.setup{}
lua require'lspconfig'.serve_d.setup{}
lua require'lspconfig'.texlab.setup{}
lua require'lspconfig'.zls.setup{}

" Trouble
lua require("trouble").setup{}

" Zig
let g:zig_fmt_autosave = 0

" treesitter
lua require'nvim-treesitter.configs'.setup {
            \ highlight = { enable = true },
            \ incremental_selection = { enable = true }
            \ }

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
            \ deoplete#manual_complete()

call deoplete#custom#option('omni_patterns', {
      \ 'r': ['[^. *\t]\.\w*', '\h\w*::\w*', '\h\w*\$\w*'],
      \})

call deoplete#custom#option('sources', {
            \ 'notmuch': ['notmuch', 'address', '--format=json', '--deduplicate=address', '*'],
            \})

call deoplete#enable()

" Autocmds

autocmd Filetype python call SetPythonOptions()
function SetPythonOptions()
    packadd indentpython.vim
    packadd vim-python-pep8-indent
    setlocal textwidth=79
    setlocal fileformat=unix
endfunction

autocmd Filetype tex call SetTeXOptions()
function SetTeXOptions()
    packadd vim-tex-conceal
    packadd vimtex
    setlocal sw=2
    setlocal textwidth=79
    setlocal iskeyword+=:
    setlocal spell! spelllang=en
endfunction

autocmd Filetype rust call SetRustOptions()
function SetRustOptions()
    packadd rust.vim
    setlocal omnifunc=v:lua.vim.lsp.omnifunc
endfunction

autocmd BufNewFile,BufRead *.jl set filetype=julia
autocmd Filetype julia call SetJuliaOptions()
function SetJuliaOptions()
    packadd julia-vim
endfunction

autocmd Filetype R call SetROptions()
autocmd Filetype noweb call SetROptions()
function SetROptions()
    packadd Nvim-R
endfunction

autocmd BufNewFile,BufRead *.none set filetype=mail
autocmd Filetype mail call SetMailOptions()
function SetMailOptions()
    packadd deoplete-notmuch
endfunction

autocmd BufNewFile,BufRead *.fish set filetype=fish
autocmd Filetype fish call SetFishOptions()
function SetFishOptions()
    packadd vim-fish
endfunction

autocmd BufNewFile,BufRead Jenkinsfile,*.Jenkinsfile call SetJenkinsfileOptions()
function SetJenkinsfileOptions()
    packadd vim-jenkins
    setf perl
endfunction

autocmd BufNewFile,BufRead *.robot set filetype=robot
autocmd Filetype robot call SetRobotOptions()
function SetRobotOptions()
    packadd robotframework-vim
endfunction

autocmd Filetype i3config call SetI3Options()
function SetI3Options()
    packadd i3config.vim
endfunction

autocmd Filetype lua call SetLuaOptions()
function SetLuaOptions()
    packadd vim-love-docs
endfunction

au BufReadPost APKBUILD set syntax=sh noexpandtab

autocmd Filetype markdown call SetMDOptions()
function SetMDOptions()
    packadd vim-markdown
endfunction

autocmd FileType yaml call SetYAMLOptions()
function SetYAMLOptions()
    packadd vim-yaml
    setlocal ts=2 sts=2 sw=2 expandtab
endfunction

autocmd FileType c call SetCOptions()
autocmd FileType cpp call SetCOptions()
function SetCOptions()
    packadd vim-lsp-cxx-highlight
endfunction

augroup LuaHighlight
  autocmd!
  autocmd TextYankPost * silent! lua require'vim.highlight'.on_yank()
augroup END

autocmd CompleteDone * silent! pclose

" vim settings

set hidden
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
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
set noea
set inccommand=split

filetype plugin indent on

syntax on

colorscheme onehalfdark
if !exists('g:neovide')
    hi Normal guibg=none
    hi LineNr guibg=none
endif
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
