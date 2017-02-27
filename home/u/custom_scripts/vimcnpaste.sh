#!/bin/bash
#

function showHelp(){
  echo
  echo "  This is a script which can get a url related to uploaded image/text from vim-cn.com"
  echo "  Usage: $1 <file-path>"
  echo
}

[ "$2"x != ""x ] && echo "Invalid arguments" && showHelp $0 && exit 1
[ "$1"x == ""x ] && echo "Missing argument" && showHelp $0 && exit 1

function isTypeEqual(){
  local t="$(file --mime-type "$2" | awk '$NF ~ /^'$1'\/.*$/ {printf $NF}')"
  [ "$t"x == ""x ] && echo -n "false" || echo -n "true"
}

if [ $(isTypeEqual 'text' "$1") == 'true' ];then
  url=$(cat "$1" | curl -sF 'vimcn=<-' https://cfp.vim-cn.com/)
elif [ $(isTypeEqual 'image' "$1") == 'true' ];then
  url=$(curl -sF "name=@$1" http://img.vim-cn.com)
else
  echo "Invalid argument (is the file's path correct?)"
  showHelp $0
  exit 1
fi

[ $? -ne 0 ] && echo 'Upload err' && exit 1
echo -n "Re: "$url && [[ "$url" =~ ^http ]] && { echo -n "$url" | xclip -selection 'clipboard' && echo '  <copied>' || echo '  <not copied>'; }
