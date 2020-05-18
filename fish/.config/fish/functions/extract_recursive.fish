function extract_recursive
    set folname (echo $argv[1] | sed 's/\.[^.]*$//')
    7z x $argv[1] -o$folname
    echo "0" > /tmp/extrout
    while read < /tmp/extrout
        find $folname \( -name '*.zip' -o -name '*.xz' -o -name '*.tar' -o -name '*.gz' -o -name "*.tgz" \) -type f -exec bash -c '7z x "{}" -o$(echo {} | sed \'s/\\.[^.]*$//\') && rm {}' \; | tee /tmp/extrout
        end
    end
end

