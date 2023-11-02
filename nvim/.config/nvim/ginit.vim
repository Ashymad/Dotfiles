if exists('g:GtkGuiLoaded')
	call rpcnotify(1, 'Gui', 'Font', 'Fira Code 13')
elseif exists('g:GuiLoaded')
	Guifont Fira Mono:h10
elseif exists('g:fvim_loaded')
    FVimFontLineHeight "-1"
    FVimCursorSmoothMove v:true
    FVimCursorSmoothBlink v:true
    FVimBackgroundOpacity 0.75
    FVimBackgroundComposition 'acrylic'
    nnoremap <A-CR> :FVimToggleFullScreen<CR>
endif

let s:font = "CodeNewRoman\\ Nerd\\ Font"
let s:fontsize = 11
:execute "set guifont=" . s:font . ":h" . s:fontsize

function! AdjustFontSize(amount)
    let s:fontsize = s:fontsize+a:amount
    :execute "set guifont=" . s:font . ":h" . s:fontsize
endfunction

noremap <C-ScrollWheelUp> :call AdjustFontSize(1)<CR>
noremap <C-ScrollWheelDown> :call AdjustFontSize(-1)<CR>
inoremap <C-ScrollWheelUp> <Esc>:call AdjustFontSize(1)<CR>a
inoremap <C-ScrollWheelDown> <Esc>:call AdjustFontSize(-1)<CR>a

let g:neovide_transparency=0.6
