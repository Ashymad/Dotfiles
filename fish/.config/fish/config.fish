#!/bin/env fish

set fish_greeting ""

alias fcd 'cd (fd -I -L -d 8 -t d . ~ | fzf)'
alias psgr 'ps aux | grep'

if test -n "$NVIM"
    alias nvim 'nvr -s'
end

source "$HOME/.cargo/env.fish"

alias cmus='tmux attach-session -t cmus || tmux new-session -A -D -s cmus ~/.local/bin/cmus'

alias :q exit
alias :e 'nvr -s'

alias :split 'swaymsg split v\; exec alacritty'
alias :vsplit 'swaymsg split h\; exec alacritty'

set ET_NO_TELEMETRY 1
set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/arista-ssh/agent.sock"
set -x PERL5LIB "$HOME/.local/lib/perl5/"
