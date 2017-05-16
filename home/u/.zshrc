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


#PROMPT="%K{24} %{$fg_bold[white]%}%n@%m %d 
#PROMPT="%K{08} %{$fg_bold[white]%}%n %K{08}%F{15}%f%k%{$reset_color%}%K{08}%F{08}%K{08}%F{15}%K{15}%F{15}%F{08}%~%K{15}%F{15}%K{15}%F{00}
#PROMPT="%K{08} %{$fg_bold[white]%}%n@%m %K{15}%F{08}%K{15}%F{08} %d %K{00}%F{15}%{$reset_color%} %F{00}%K{14}%{$reset_color%}%F{14}%K{24} %{$fg_bold[white]%}%# %K{00}%F{24}%{$reset_color%} %f%k"

setopt PROMPT_SUBST
#function precmd() {
# function clearScr() {
#   if [ "$clearScreen"x == "1"x ];then
#     clear
#     export clearScreen=0
#   fi
# }
# precmd () {print -Pn "\e]0;%n@%m: %~\a"; echo; clearScr}
precmd () {print -Pn "\e]0;%n@%m: %~\a";}
PROMPT="%K{236}%F{15} %n %f%k%K{236}%F{07}%K{07}%F{07} %F{08}%~%K{07}%F{07} %K{07}%F{234}%f%k
 %F{234}%K{45} %F{45}%K{24} %{$fg_bold[white]%}%# %K{234}%F{24} %{$reset_color%} %f%k"
#}
RPROMPT="%F{81} %w %{$reset_color%}%*%K{234}%F{15} %K{15}%F{00} %h %f%k"
preexec () {print -Pn "\e]0;> $1   %n@%m: %~\a"}

source /home/royuz/.zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
source /home/royuz/.dvm/dvm.sh
# export clearScreen=1
export GOPATH=/home/royuz/go
