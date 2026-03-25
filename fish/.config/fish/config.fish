#!/bin/env fish

set fish_greeting ""

alias fcd 'cd (fd -I -L -d 8 -t d . ~ | fzf)'
alias psgr 'ps aux | grep'

if test -n "$NVIM"
    alias nvim 'nvr -s'
end

if test -f "$HOME/.cargo/env.fish"
    source "$HOME/.cargo/env.fish"
end

alias cmus='tmux attach-session -t cmus || tmux new-session -A -D -s cmus ~/.local/bin/cmus'

alias :q exit
alias :e 'nvr -s'

alias :split 'swaymsg split v\; exec alacritty'
alias :vsplit 'swaymsg split h\; exec alacritty'

set ET_NO_TELEMETRY 1

if test -f "$XDG_RUNTIME_DIR/arista-ssh/agent.sock"
    set -x SSH_AUTH_SOCK "$XDG_RUNTIME_DIR/arista-ssh/agent.sock"
end

set -x PERL5LIB "$HOME/.usr/local/lib/perl5/"
set -x XDG_DATA_DIRS $XDG_DATA_DIRS "$HOME/.usr/local/share"

#direnv hook fish | source

# pnpm
set -gx PNPM_HOME "/home/shyman/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
  set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
