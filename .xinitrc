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

# Config for dwm
picom -b
xset b off
~/.fehbg &
sh $HOME/scripts/dwm_status &
blueman-applet &
dbus-launch nm-applet &
# dbus-launch perf record --call-graph dwarf dwm
exec dbus-launch dwm
# exec dbus-launch xfwm4
