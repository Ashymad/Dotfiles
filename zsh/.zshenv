skip_global_compinit=1

if [[ $SWAY_ENV != 1 ]]; then
    source <(~/.local/bin/withenv --export ~/.config/sway/env)
fi

export MISE_Found="$(which mise &>/dev/null; echo $?)"
tools=( 'vivid' 'nvim' )
declare -A tool_paths

for tool in "${tools[@]}"; do
    if [[ $MISE_Found == 0 ]] && tool_path="$(mise x -- which $tool)"; then
        tool_paths[$tool]="$tool_path"
    elif tool_path="$(which $tool)"; then
        tool_paths[$tool]="$tool_path"
    fi
done

[ -n "${tool_paths[nvim]}" ] && export EDITOR="${tool_paths[nvim]}" && export SUDO_EDITOR="$EDITOR"
[ -n "${tool_paths[vivid]}" ] && export LS_COLORS="$(${tool_paths[vivid]} generate rose-pine-moon)"

export PERL5LIB="$HOME/.usr/local/lib/perl5/"
[ -f "$XDG_RUNTIME_DIR/arista-ssh/agent.sock" ] && export SSH_AUTH_SOCK="$XDG_RUNTIME_DIR/arista-ssh/agent.sock"
export ZSH_EXEC=1
export HOST
