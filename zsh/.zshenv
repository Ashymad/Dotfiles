skip_global_compinit=1

SWAY_ENV_FILE=~/.config/sway/env
SWAY_ENV_SHA="$(sha1sum "$SWAY_ENV_FILE" | cut -d' ' -f1)"
if [[ $SWAY_ENV != $SWAY_ENV_SHA ]]; then
    source <(~/.local/bin/withenv -e -f "$SWAY_ENV_FILE")
fi
unset SWAY_ENV_FILE
unset SWAY_ENV_SHA

export EDITOR="$(which nvim)"
export SUDO_EDITOR="$EDITOR"
export VIVID_THEME=rose-pine-moon
export ZSH_EXEC=1
export HOST

[ -f "$XDG_RUNTIME_DIR/arista-ssh/agent.sock" ] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/arista-ssh/agent.sock"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
