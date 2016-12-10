#!/bin/bash
#
# Written by Bekcpear

ds=0 # The default number of output sentences, from 1 to 10, 0 means all

urlPrefix="https://en."
url="wikipedia.org/w/api.php?format=json&action=query&prop=extracts&explaintext="
proxy=""
[ "$proxy"x != ""x ] && proxy="--socks5 $proxy" 
judgeSentence=$ds
loopS=2
function info(){
  echo "Usage: $0 [-s num] \"Query String\""
  printf "\n   -s num       limited how many sentences output (from 1-10, default[$ds] for all sentences)\n\n"
  exit 1
}

function mainQ(){
  data=$(curl $proxy -s --data-urlencode "titles=$query" "$qurl" | tr "'" "^" )
  id=$(jq . <<< $data |  grep '"pageid":' | tr ',' ' ' | awk '{printf $2}')
  [ -z $id ] && echo -e "\e[0;33m  No result of \"$query\"\e[0m" && echo && exit
  mainStr=$(eval "echo '$data' | jq '.query? | .pages? | .\"$id\"? | .extract?'" | tr "^" "'")
  mainStr=$(echo "${mainStr:1:-1}" | sed 's/%/<percent>/g')
  if [ "$1"x == "1"x ];then
    mainStr=$(echo $mainStr | sed 's/^.*may\srefer\sto:\\n\\n//')
    echo -e "\e[0;33m  Further result:\e[0m"
  else
    echo -e "\e[0;33m  Result:\e[0m" 
  fi
  printf "$mainStr" | sed 's/^\(.*[^:]\)$/  \1/' | sed '/\.$/i.\' | sed '/\。$/i.\' | sed 's/<percent>/%/g'
  echo
}

[ -z "$1" ] && info

query="$1"
[ "$1"x == "-s"x ] && { judgeSentence=-1; loopS=4; [[ "$2" =~ ^[0-9]+$ ]] && judgeSentence=$2 || info; [ -z "$3" ] && info || query="$3"; }
[ $judgeSentence -gt 10 -o $judgeSentence -lt 0 ] && echo -e "\e[0;33mWarning: a invalid num, restore to default.\e[0m;" && judgeSentence=$ds

while [ $? ];do
  eval "word=\$$loopS"
  [ -z "$word" ] && break
  [ "$word" == "-s" ] && loopS=$(($loopS + 1)) && { eval "judgeSentence=\$$loopS"; [ -z $judgeSentence ] && info && exit || break; }
  eval "query='$query '$word"
  loopS=$(($loopS + 1))
  [ $loopS -gt 9 ] && echo -e "\e[0;33mToo many word. Please paste here or quote them.\e[0m" \
    && read -p ">> " -e -r query \
    && break
done

[[ "$query" =~ [一-龥]+ ]] && urlPrefix="https://zh."
qurl="$urlPrefix""$url"$( [ $judgeSentence -eq 0 ] || printf "&exsentences="$judgeSentence )"&exintro=&"
echo "  Please wait.."
echo
mainQ

[[ "$mainStr" =~ refer\ to:$ ]] \
  && qurl="$urlPrefix""$url"$( [ $judgeSentence -eq 0 ] || printf "&exsentences="$judgeSentence )"&" \
  && echo \
  && echo -e "  \e[0;33mFurther queries, please wait..\e[0m" \
  && echo \
  && mainQ 1
