function aur-cleanup
    source ~/.config/fish/utils/pacmsg.fish
    msg1 "Cleaning pacman cache..."
    sudo pacman -Sc --noconfirm
    msg1 "Rebuilding custom repositories..."
    for repo in /var/cache/pacman/*custom*
        cd $repo
        set reponame (basename $repo)
        rm $reponame.db*
	set pkgs *.pkg.tar.xz
        repo-add -n $reponame.db.tar $pkgs
    end
    sudo pacman -Sy
    msg1 "Cleaning aur sync cache..."
    cd ~/.cache/aurutils/sync
    for dir in *
        set pkgname (bash -c "source $dir/PKGBUILD;"'echo $pkgname')
        if not pacman -Qi $pkgname >/dev/null 2>/dev/null
            echo "Removing $dir..."
            rm -rf -- $dir
        else
            set reponame (pacman -Ss '^'(string escape --style=regex $pkgname)'$' | head -1 | sed 's@/.*$@@g')
            if string match -q 'custom*' $reponame
                cd $dir
                git clean -xdf
                cd ..
            else
                echo "Removing $dir..."
                rm -rf -- $dir
            end
        end
    end
end

