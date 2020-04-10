function aur-resync-devel
    set packages (aur repo --list | cut -f1 | grep -E "$AURVCS")
    aur sync $packages --no-ver --print
end

