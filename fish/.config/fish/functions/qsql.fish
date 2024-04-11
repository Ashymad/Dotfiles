function qsql
    set PASS ($HOME/Documents/Workspace/Dotfiles/astroid/.config/astroid/get_pass.py "https://$argv[1].db.qual.control-tec.com")
    mysql -h $argv[1].db.qual.control-tec.com -u smikulicz -p$PASS $argv[2..]
end
