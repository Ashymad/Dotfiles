#!/bin/env fish

set fish_greeting ""

alias ec "emacsclient -a \"\""
alias fcd 'cd (fd -I -L -d 8 -t d . ~ | fzf)'
alias bash 'env FISH_RAMP_DISABLE=1 bash'
alias psgr 'ps aux | grep'
alias vim nvim

alias wine64 'env WINEPREFIX=/home/shyman/.wine64 WINEARCH=win64 wine'
alias wine64cfg 'env WINEPREFIX=/home/shyman/.wine64 WINEARCH=win64 winecfg'
alias wine64tricks 'env WINEPREFIX=/home/shyman/.wine64 WINEARCH=win64 winetricks'

alias wine32 'env WINEPREFIX=/home/shyman/.wine32 WINEARCH=win32 wine'
alias wine32cfg 'env WINEPREFIX=/home/shyman/.wine32 WINEARCH=win32 winecfg'
alias wine32tricks 'env WINEPREFIX=/home/shyman/.wine32 WINEARCH=win32 winetricks'

source /usr/share/autojump/autojump.fish
