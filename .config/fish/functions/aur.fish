function aur --wraps aur
	if test -f "$HOME/.config/fish/functions/aur-$argv[1].fish"
		eval "aur-$argv[1]" $argv[2..-1]
	else
		/usr/bin/aur $argv
	end
end

