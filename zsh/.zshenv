skip_global_compinit=1

ENV_FILE=~/.global/env
ENV_SHA="$(sha1sum "$ENV_FILE" | cut -d' ' -f1)"
if [[ ${_ENV_SHA1SUM} != $ENV_SHA ]]; then
    source <(~/.local/bin/withenv -e -f "$ENV_FILE")
fi
unset ENV_FILE
unset ENV_SHA

export EDITOR="env TERM=mlterm-direct $(which emacsclient) -nw -a ''"
export SUDO_EDITOR="$EDITOR"
export VIVID_THEME=rose-pine-moon
export ZSH_EXEC=1
export HOST

[ -f "$XDG_RUNTIME_DIR/arista-ssh/agent.sock" ] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/arista-ssh/agent.sock"
[ -f "$HOME/.cargo/env" ] && . "$HOME/.cargo/env"
