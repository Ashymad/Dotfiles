if exists('g:GtkGuiLoaded')
	call rpcnotify(1, 'Gui', 'Font', 'Source Code Pro Nerd Font 13')
elseif exists('g:GuiLoaded')
	Guifont FuraCode Nerd Font Mono:h13
endif
