#!/bin/env fish

fish_config theme choose "Rosé Pine"

set fish_greeting ""

alias ec "emacsclient -a \"\""
alias fcd 'cd (fd -I -L -d 8 -t d . ~ | fzf)'
alias bash 'env FISH_RAMP_DISABLE=1 bash'
alias psgr 'ps aux | grep'

set -g PATH (bash -c -i 'source ~/.bash_profile; echo $PATH') ~/.deno/bin/

if test -n "$NVIM"
    alias nvim nvr
end

alias vim nvim

alias wine64 'env WINEPREFIX=/home/shyman/.wine64 WINEARCH=win64 wine'
alias wine64cfg 'env WINEPREFIX=/home/shyman/.wine64 WINEARCH=win64 winecfg'
alias wine64tricks 'env WINEPREFIX=/home/shyman/.wine64 WINEARCH=win64 winetricks'

alias wine32 'env WINEPREFIX=/home/shyman/.wine32 WINEARCH=win32 wine'
alias wine32cfg 'env WINEPREFIX=/home/shyman/.wine32 WINEARCH=win32 winecfg'
alias wine32tricks 'env WINEPREFIX=/home/shyman/.wine32 WINEARCH=win32 winetricks'

alias cmus='tmux attach-session -t cmus || tmux new-session -A -D -s cmus /usr/bin/cmus'

alias :q exit
alias :e nvr
if test "$XDG_SESSION_TYPE" = "x11"
    alias :split 'i3-msg split v\; exec alacritty > /dev/null'
    alias :vsplit 'i3-msg split h\; exec alacritty > /dev/null'
else
    alias :split 'swaymsg split v\; exec alacritty'
    alias :vsplit 'swaymsg split h\; exec alacritty'
end

alias noproxy 'env http_proxy="" https_proxy="" ftp_proxy=""'

source /usr/share/autojump/autojump.fish
direnv hook fish | source
