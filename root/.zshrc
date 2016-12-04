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

precmd () {print -Pn "\e]0;%n@%m: %~\a"}
RPROMPT="%{$fg_bold[white]%}%F{218}%w %{$reset_color%}%*%K{234}%F{15} %K{15}%F{00} %h %f%k"
#PROMPT="%K{24} %{$fg_bold[white]%}%n@%m %d 
#PROMPT="%K{08} %{$fg_bold[white]%}%n@%m %K{15}%F{08}%K{15}%F{08} %d %K{00}%F{15}%{$reset_color%} %F{00}%K{14}%{$reset_color%}%F{14}%K{24} %{$fg_bold[white]%}%# %K{00}%F{24}%{$reset_color%} %f%k"
#PROMPT="%K{08} %{$fg_bold[white]%}%n %K{08}%F{15}%f%k%{$reset_color%}%K{08}%F{08}%K{08}%F{15}%K{15}%F{15}%F{08}%~%K{15}%F{15}%K{15}%F{00}
PROMPT="%K{08} %{$fg_bold[white]%}%n %f%k%{$reset_color%}%K{08}%F{7}%K{7}%F{7}%F{08}%~%K{7}%F{7}%K{7}%F{234}
%{$reset_color%} %F{234}%K{218}%F{218}%K{197} %{$fg_bold[white]%}%# %{$reset_color%}%K{234}%F{197}%{$reset_color%} %f%k"
preexec () {print -Pn "\e]0;> $1   %n@%m: %~\a"}
source /home/royuz/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/royuz/.dvm/dvm.sh
