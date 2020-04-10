function aur-update-devel
    set packages (aur vercmp-devel | cut -d: -f1)
    if not test -z "$packages"
	aur sync $packages --no-ver-argv
    end
end
