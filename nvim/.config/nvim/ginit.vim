if exists('g:GtkGuiLoaded')
	call rpcnotify(1, 'Gui', 'Font', 'Fira Code 13')
elseif exists('g:GuiLoaded')
	Guifont Fira Mono:h10
endif
