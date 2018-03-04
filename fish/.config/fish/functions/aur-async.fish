function aur-async
	 aur sync --repo=custom-aur -f --no-ver $argv
	 sudo pacman -S $argv[1]
end

