function neovide
    set DISADR (echo $DISPLAY | cut -d':' -f1)
    if test -n "$DISADR" 
        set LOCADR (ip -f inet addr show enp60s0u1u3u3 | sed -En -e 's/.*inet ([0-9.]+).*/\1/p')
        nohup nvim --listen $LOCADR:8118 --headless $argv >/dev/null 2>&1 &
        disown
        ssh -T shyman@$DISADR "env DISPLAY=:0 neovide --remote-tcp $LOCADR:8118"
    else
        /home/mikulicz/Workspace/neovide/target/release/neovide -- $argv
    end
end
