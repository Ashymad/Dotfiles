function aur-update-devel
        aur vercmp-devel | cut -d: -f1 | aur sync --no-ver-shallow -
end
