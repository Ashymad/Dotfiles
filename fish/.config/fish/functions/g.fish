#!/usr/bin/env fish
function g
    set len (count $argv)
    if test $len -gt 0
        switch $argv[1]
        case "s"
            git status $argv[2..$len]
        case "a"
            git add $argv[2..$len]
        case "c"
            git commit $argv[2..$len]
        case "p"
            git push $argv[2..$len]
        case "pl"
            git pull $argv[2..$len]
        case "ch"
            git checkout $argv[2..$len]
        case "d"
            git diff $argv[2..$len]
        case "m"
            git merge $argv[2..$len]
        case '*'
            git $argv
        end
    end
end
