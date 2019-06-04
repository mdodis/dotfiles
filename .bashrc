#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return

alias ls='ls --color=auto'
## My config
export PATH=$PATH:"~/scripts":"~/.local/bin"
export PS1="\[\e[1;30;44m\]\h\[\e[m\]\[\e[1;30;42m\]\u\[\e[m\] \W)⮞ "
export SUDO_ASKPASS="$HOME/scripts/dmenupass"
export XDG_CURRENT_DESKTOP=XFCE
export PKG_CONFIG_PATH="/usr/lib/pkgconfig"

alias open=xdg-open
alias subl='subl3 -a'		# unfuck sublime text
alias prename=perl-rename
alias vimdiff='vim -d'
alias md2pdf='python -m md2pdf'
alias love="~/work/love-11.2-x86_64.AppImage"


## ls outputs bad colors on o+w folders
export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"
export NVIM_TUI_ENABLE_TRUE_COLOR=1
## unfuck nautilus Open Terminal to open terminator
#if ps -o cmd= -p $(ps -o ppid= -p $$) | grep -q gnome; then
#  nohup st &> /dev/null &
#  sleep 0.1s
#  exit
#fi

# don't even ask why
EDITOR="/usr/bin/nvim"

alias l="ls -al"
alias vi=vim ##novi
tput smkx ## st delete key

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi
