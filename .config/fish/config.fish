#!/bin/env fish

alias ec "emacsclient -a \"\""
alias fcd 'cd (fd -I -L -d 8 -t d . ~ | fzf)'
alias bash 'env FISH_RAMP_DISABLE=1 bash'
alias psgr 'ps aux | grep'
source /usr/share/autojump/autojump.fish



