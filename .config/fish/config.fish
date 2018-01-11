#!/bin/env fish

alias ec "emacsclient -a \"\""
alias fcd 'cd (fd -I -L -d 8 -t d . ~ | fzf)'
alias bash 'env FISH_RAMP_DISABLE=1 bash'
alias psgr 'ps aux | grep'

function reverse_search
	commandline -r (grep '^- cmd: '  ~/.local/share/fish/fish_history | cut -c 8- | fzf)
end


function fish_user_keybindings
	bind \cr reverse_search
end

