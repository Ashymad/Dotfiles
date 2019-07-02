#!/usr/bin/env fish
function g
    set len (count $argv)
    if test $len -gt 0
        if test $len -gt 1
            set rest $argv[2..$len]
        else
            set rest
        end
        switch $argv[1]
        case "s"
            git status 
        case "a"
            git add $rest
        case "c"
            git commit $rest
        case "p"
            git push $rest
        case "pl"
            git pull $rest
        case "ch"
            git checkout $rest
        case "d"
            git diff $rest
        case "m"
            git merge $rest
        case '*'
            git $argv
        end
    end
end
