#!/usr/bin/env fish
function aur
    if test -f "$HOME/.config/fish/functions/aur-$argv[1].fish"
        eval "aur-$argv[1]" $argv[2..-1]
    else if test -f "$HOME/.config/fish/functions/aur-$argv[1].sh"
        bash "$HOME/.config/fish/functions/aur-$argv[1].sh"
    else
        /usr/bin/aur $argv
    end
end

