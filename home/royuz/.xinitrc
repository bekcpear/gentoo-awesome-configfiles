export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=fcitx
export GTK_IM_MODULE=fcitx
#export XMODIFIERS="@im=ibus"
#export QT_IM_MODULE=ibus
#export GTK_IM_MODULE=ibus
#export GTK_IM_MODULE_FILE=/usr/lib/gtk-3.0/3.0.0/immodules.cache

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

/home/royuz/customScript/ssProxyStart
fcitx &
owncloud &
#ibus-daemon -dx
xcompmgr &
devilspie -a &
exec awesome
#exec dbus-launch --sh-syntax --exit-with-session awesome
#exec openbox
