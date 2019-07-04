function aur-cleanup
	source ~/.config/fish/utils/pacmsg.fish
	msg1 "Cleaning pacman cache..."
	sudo pacman -Sc --noconfirm
	msg1 "Rebuilding custom repositories..."
	for repo in /var/cache/pacman/*custom*
		cd $repo
        set reponame (basename $repo)
        rm $reponame.db*
        repo-add -n $reponame.db.tar *.pkg.tar.xz
	end
	sudo pacman -Sy
	msg1 "Cleaning aur sync cache..."
	cd ~/.cache/aurutils/sync
	for dir in *
		set pkgname (bash -c "source $dir/PKGBUILD;"'echo $pkgname')
		if not pacman -Qi $pkgname >/dev/null 2>/dev/null
			echo "Removing $dir..."
			rm -rf -- $dir
		end
	end
end

