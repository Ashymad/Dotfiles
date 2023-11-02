function aur-cleanup
    source ~/.config/fish/utils/pacmsg.fish
    msg1 "Cleaning pacman cache..."
    sudo pacman -Sc --noconfirm
    msg1 "Rebuilding custom repositories..."
    set repos (awk '{
        if ($1 ~ /\[.*\]/) {
            name = gensub(/\[(.*)\]/, "\\\\1", 1, $1)
        } else if ($1 ~ /Server/) {
            sub(/.*Server.*=.*file:\/\//, "");
            print name ":" $0
        }
    }' /etc/pacman.conf)

    for i in (seq (count $repos))
        set reponames[$i] (echo $repos[$i] | cut -d':' -f1)
        set repodirs[$i] (echo $repos[$i] | cut -d':' -f2)
        set pkgs $repodirs[$i]/*.pkg.tar.xz
        rm $repodirs[$i]/$reponames[$i].db.tar
        repo-add -n $repodirs[$i]/$reponames[$i].db.tar $pkgs
    end
    sudo pacman -Sy
    msg1 "Cleaning aur sync cache..."
    for dir in ~/.cache/aurutils/sync/*
        set pkgname (bash -c "source $dir/PKGBUILD;"'echo $pkgname')
        if not pacman -Qi $pkgname >/dev/null 2>/dev/null
            echo Removing $dir...
            rm -rf -- $dir
        else
            set reponame (pacman -Ss '^'(string escape --style=regex $pkgname)'$' | head -1 | sed 's@/.*$@@g')
            if contains $reponame $reponames
                git -C $dir clean -xdf
            else
                echo Removing $dir...
                rm -rf -- $dir
            end
        end
    end
end

