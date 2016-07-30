# Lines configured by zsh-newuser-install
HISTFILE=~/.histfile
HISTSIZE=10000
SAVEHIST=10000
bindkey -v
# End of lines configured by zsh-newuser-install
# The following lines were added by compinstall
zstyle :compinstall filename '/home/royuz/.zshrc'

#autoload -Uz compinit
#compinit
# End of lines added by compinstall

zstyle ':completion::complete:*' use-cache 1
#zstyle ':completion:*:descriptions' format '%U%B%d%b%u'
#zstyle ':completion:*:warnings' format '%BSorry, no matches for: %d%b'

autoload -Uz compinit promptinit colors
colors
compinit
promptinit

RPROMPT="%{$fg_bold[cyan]%} %D{%f} %{$reset_color%}%* ➤%h"
PROMPT="%{$bg[cyan]%} %# %{$fg_bold[white]%}%n@%m %d 
%{$reset_color%}%{$fg_bold[cyan]%}➥ "
source /home/royuz/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
