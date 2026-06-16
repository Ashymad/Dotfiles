skip_global_compinit=1

SWAY_ENV_FILE=~/.config/sway/env
SWAY_ENV_SHA="$(sha1sum "$SWAY_ENV_FILE" | cut -d' ' -f1)"
if [[ $SWAY_ENV != $SWAY_ENV_SHA ]]; then
    source <(~/.local/bin/withenv -e -f "$SWAY_ENV_FILE")
fi
unset SWAY_ENV_FILE
unset SWAY_ENV_SHA

export MISE_Found="$(which mise &>/dev/null; echo $?)"
tools=( 'nvim' )
declare -A tool_paths

for tool in "${tools[@]}"; do
    if [[ $MISE_Found == 0 ]] && tool_path="$(mise x -- which $tool)"; then
        tool_paths[$tool]="$tool_path"
    elif tool_path="$(which $tool)"; then
        tool_paths[$tool]="$tool_path"
    fi
done

[ -n "${tool_paths[nvim]}" ] && export EDITOR="${tool_paths[nvim]}" && export SUDO_EDITOR="$EDITOR"

export VIVID_THEME=rose-pine-moon
[ -f "$XDG_RUNTIME_DIR/arista-ssh/agent.sock" ] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/arista-ssh/agent.sock"
export ZSH_EXEC=1
export HOST
