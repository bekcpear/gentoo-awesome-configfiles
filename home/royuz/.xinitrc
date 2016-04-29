export XMODIFIERS="@im=fcitx"
export QT_IM_MODULE=xim
export GTK_IM_MODULE=xim

[[ -f ~/.Xresources ]] && xrdb -merge -I$HOME ~/.Xresources

/home/royuz/customScript/ssProxyStart
fcitx
xcompmgr &
devilspie -a &
exec ck-launch-session dbus-launch --sh-syntax --exit-with-session awesome
