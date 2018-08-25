function aur-resync-devel
	aur sync --list | cut -f2 | grep -E -- "-$AURVCS" | xargs aur sync --no-ver --print
end

