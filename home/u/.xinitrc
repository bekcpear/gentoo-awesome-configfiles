export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
export SDL_IM_MODULE=fcitx
#export XMODIFIERS="@im=ibus"
#export QT_IM_MODULE=ibus
#export GTK_IM_MODULE=ibus
#export GTK_IM_MODULE_FILE=/usr/lib/gtk-3.0/3.0.0/immodules.cache

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

/home/royuz/customScripts/ssProxy start r
http_proxy=127.0.0.1:8123 https_proxy=127.0.0.1:8123 fcitx &
owncloud &
#ibus-daemon -dx
xcompmgr &
devilspie2 &
redshift -t 5500K:4500K &
#/home/royuz/Telegram/Telegram &
exec awesome
#exec dbus-launch --sh-syntax --exit-with-session awesome
#exec openbox
