##这里是一些更新说明


###2016-11-28
1. 创建 [home/royuz/custom\_scripts/](../home/royuz/custom_scripts) 目录，一些脚本会放到里面去。关于脚本的说明看该目录下说明文档


###2016-10-09
1. 因为 musicbox 在 xterm 下播放总是出现闪烁的问题，没解决。遂决定换成 sakura 终端使用 musicbox ，并绑定在一起使用赋予图标和标题。
2. 原来的 devilspie 解决窗口透明的这个软件配置文件实在太过于奇葩，发现了 devilspie2 采用 lua 语言编写配置文件的，遂直接更换使用。而且这个还可以很方便地制定对应窗口的众多属性，比如座标和尺寸。
3. 针对于第一点，直接用脚本固定 mymusic 命令打开 sakura 并运行 musicbox 。

几个没有 push 上来的配置如下：

*/usr/bin/mymusic*
```
#!/bin/zsh
#

/usr/bin/sakura -t "Netease Music Box" -x /usr/bin/musicbox
```

*/usr/share/applications/netease-musicbox.desktop*
```
[Desktop Entry]
Type=Application
Name=NetEase MusicBox
Comment=NetEase MusicBox
Exec=mymusic
Categories=AudioVideo;Player;
```

sakura 默认从 `/usr/share/pixmaps/` 这个目录下读取 `terminal-tango.svg` 这个图标使用，直接改成自己修改的网易云音乐的矢量图标![图标](mis/netease-cloud-music.svg)

目前 musicbox 看上去的样子：
![musicbox screenshot](mis/musicbox_screenshot_with_sakura_terminal.png)
