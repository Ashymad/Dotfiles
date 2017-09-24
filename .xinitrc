[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xbindkeys
urxvtd -q -o -f
[[ -f ~/.fehbg ]] && ~/.fehbg
xinput set-prop 10 144 1.850000, 0.000000, 0.000000, 0.000000, 1.850000, 0.000000, 0.000000, 0.000000, 1.000000
exec i3
