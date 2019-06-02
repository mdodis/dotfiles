#!/bin/sh

userresources=$HOME/.Xresources
usermodmap=$HOME/.Xmodmap
sysresources=/etc/X11/xinit/.Xresources
sysmodmap=/etc/X11/xinit/.Xmodmap

# merge in defaults and keymaps

if [ -f $sysresources ]; then







    xrdb -merge $sysresources

fi

if [ -f $sysmodmap ]; then
    xmodmap $sysmodmap
fi

if [ -f "$userresources" ]; then







    xrdb -merge "$userresources"

fi

if [ -f "$usermodmap" ]; then
    xmodmap "$usermodmap"
fi

# start some nice programs

sh /home/miked/.screenlayout/extend.sh
compton -b
feh --bg-scale "/home/miked/Pictures/Wallpapers/Hyper Beast Dark.png"

sh $HOME/scripts/dwm_status &

numlockx &
#dunst &
discord &
firefox &
thunderbird &
dbus-launch dwm
