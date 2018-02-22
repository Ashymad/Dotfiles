#!/bin/env fish

set fish_greeting ""

alias ec "emacsclient -a \"\""
alias fcd 'cd (fd -I -L -d 8 -t d . ~ | fzf)'
alias bash 'env FISH_RAMP_DISABLE=1 bash'
alias psgr 'ps aux | grep'
alias vim nvim

source /usr/share/autojump/autojump.fish



