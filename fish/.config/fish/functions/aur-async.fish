function aur-async
	 aur sync -f --no-ver $argv
	 and sudo pacman -S $argv
end

