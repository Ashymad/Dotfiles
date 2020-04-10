function rollback
    set Y (date --date "$argv" +%Y)
    set m (date --date "$argv" +%m)
    set d (date --date "$argv" +%d)
    sudo mv /etc/pacman.d/mirrorlist /etc/pacman.d/mirrorlist.bkp
    echo "Server=https://archive.archlinux.org/repos/$Y/$m/$d/"'$repo/os/$arch' | sudo tee /etc/pacman.d/mirrorlist
    sudo timedatectl set-ntp false
    sudo timedatectl set-time "$Y-$m-$d"
    sudo pacman -Syyuu
    sudo timedatectl set-ntp true
    sudo hwclock --systohc
    sudo mv /etc/pacman.d/mirrorlist.bkp /etc/pacman.d/mirrorlist
end

