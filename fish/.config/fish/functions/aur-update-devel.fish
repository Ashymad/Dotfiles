function aur-update-devel
        aur vercmp-devel | cut -d: -f1 >/tmp/vcs.txt
	xargs -a /tmp/vcs.txt aur sync --no-ver-shallow
end
