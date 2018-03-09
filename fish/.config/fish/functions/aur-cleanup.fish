function aur-cleanup
	set_color -o blue
	echo -n ":: "
	set_color -o white
	echo "Cleaning pacman cache..."
	set_color normal
	sudo pacman -Sc --noconfirm
	set_color -o blue
	echo -n ":: "
	set_color -o white
	echo "Updating custom repositories..."
	set_color normal
	for repo in /var/cache/pacman/*custom*
		cd $repo
		repose -zvf (basename $repo)
	end
	sudo pacman -Sy
	set_color -o blue
	echo -n ":: "
	set_color -o white
	echo "Cleaning aur sync cache..."
	set_color normal
	cd ~/.cache/aurutils/sync
	for dir in *
		set pkgname (bash -c "source $dir/PKGBUILD;"'echo $pkgname')
		if not pacman -Qi $pkgname >/dev/null 2>/dev/null
			echo "Removing $dir..."
			rm -rf -- $dir
		end
	end
end

