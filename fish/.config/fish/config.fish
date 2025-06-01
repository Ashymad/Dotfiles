#!/bin/env fish

set fish_greeting ""

alias fcd 'cd (fd -I -L -d 8 -t d . ~ | fzf)'
alias psgr 'ps aux | grep'

if test -n "$NVIM"
    alias nvim 'nvr -s'
end

alias cmus='tmux attach-session -t cmus || tmux new-session -A -D -s cmus /usr/bin/cmus'

alias :q exit
alias :e 'nvr -s'

alias :split 'swaymsg split v\; exec alacritty'
alias :vsplit 'swaymsg split h\; exec alacritty'

#direnv hook fish | source
