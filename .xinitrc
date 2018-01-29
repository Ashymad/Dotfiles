[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources
xbindkeys
urxvtd -q -o -f
[[ -f ~/.fehbg ]] && ~/.fehbg
xinput set-prop 10 285 0, 1
exec i3
#exec sbcl --load startstumpwm
