
# Here's the bashrc. I don't exactly understand if I should
# put some of the stuff here elsewhere, like bash_profile or
# whatever. But since it seems like it's working good, I won't
# complain.

[[ $- != *i* ]] && return                       # If not running interactively, don't do anything

bind TAB:menu-complete
alias ls='ls --color=auto'
export PATH=$PATH:"~/scripts":"~/.local/bin"    # Nothing to see here
export SUDO_ASKPASS="$HOME/scripts/dmenupass"   # Modularity™
export XDG_CURRENT_DESKTOP=XFCE                 # Fixes some QT apps
export PKG_CONFIG_PATH="/usr/lib/pkgconfig"     # Yup
export EDITOR="/usr/bin/nvim"                   # don't even ask why

export LS_COLORS="$LS_COLORS:ow=1;34:tw=1;34:"  # ls outputs bad colors on o+w folders
export NVIM_TUI_ENABLE_TRUE_COLOR=1             # when I was trying to get full-color
export QT_QPA_PLATFORMTHEME=qt5ct
# Sexy prompt that only looks good if bold isn't bright
export PS1="\[\e[1;30;44m\]\h\[\e[m\]\[\e[1;30;42m\]\u\[\e[m\] \W)⮞ "
export QEMU_AUDIO_DRV=alsa

alias open=xdg-open
alias subl='subl -a'		                    # better sublime-text terminal "cli"
alias prename=perl-rename                       # pretty useless if u have ranger
alias vimdiff='vim -d'                          # diffit
alias pacfiles="pacman -Ql"                     # I always forget the right command dammit
alias l="ls -al"                                # Custom linux by Michael Dodis CORP®
alias y2mp3="youtube-dl -x --audio-format mp3"  # youtube-dl
alias 4edc="cd .local/bin/4coder-linux-x64-super/4coder/"
alias protoc='python -m grpc_tools.protoc'
alias vi=nvim                                   # neovim
alias vim=nvim                                  # Neovim!
alias VIM=nvim                                  # NEOVIM!
alias 4ed="~/.local/bin/4coder-linux-x64-super/4coder/4ed -f 11"
# Don't even understand how it works, but I still want to customize it. Yay.
#alias nethack="NETHACKOPTIONS=DECGraphics=true,statushilites:10,showexp,time=true,rest_on_space=false,autopickup=false nethack"
alias nethack="NETHACKOPTIONS=showexp,time=true,rest_on_space=false,autopickup=false,perm_invent,windowtype:curses nethack"

alias openvpn="sudo openvpn --config ~/Documents/client.ovpn"
# Why would any sane person want an installer to change
# their shell config, adding a bunch of milliseconds on
# startup? Seriously, we had package managers to manage package
# versions, and distribution.
#
# Now we have a package manager that manages python versions, and
# the packages that come with it. The moment my project with python
# ends I'm uninstalling this monstrosity. And to think the promise
# of higher-level (than C) languages was simplicity. I'd rather write
# billions of lines in C. Thanks, Obama.

tput smkx                                       # st delete key
# startx on login
if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    startx
fi

## unfuck nautilus Open Terminal to open terminator
## don't use nautilus anymore, but will keep just in case
#if ps -o cmd= -p $(ps -o ppid= -p $$) | grep -q gnome; then
#  nohup st &> /dev/null &
#  sleep 0.1s
#  exit
#fi
