function git-subpush
    set sub (basename (pwd))
    git push
    pushd ..
    git add $sub
    git commit -m "Update $sub"
    git push
    popd
end
