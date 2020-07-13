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

set guifont=Fira\ Code:h14
nnoremap <silent> <C-ScrollWheelUp> :set guifont=+<CR>
nnoremap <silent> <C-ScrollWheelDown> :set guifont=-<CR>
