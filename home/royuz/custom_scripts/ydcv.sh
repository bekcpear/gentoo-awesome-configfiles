#!/bin/bash
#
# Created by Bekcpear

blackCharOpt="break"
apif=""
apikey=""

function iniQ(){
  r=$(eval "echo '$data' | jq '$1'")
}

function longStrFac(){
  local str=$1
  local arg=$2
  local i=0
  eval "unset $arg"

  while [ $i -ge 0 ];do
    local t=$(eval "echo '$str' | jq '.[$i]?' | sed 's/\"//g'")
    t=$(echo "$t" | tr " " "_")
    eval "$arg[$i]='$t'"
    if [ "$t"x == "null"x ];then
      eval "unset $arg[$i]"
      i=-1
    else
      i=$(($i + 1))
    fi
  done
}

function main(){

  unset data query translation ph usph ukph explainsArray webArray

  data=$(curl -s --data-urlencode "q=$tranStr" "http://fanyi.youdao.com/openapi.do?keyfrom=$apif&key=$apikey&type=data&doctype=json&version=1.1&" | tr "'" "^")
  r=""

  iniQ '.errorCode'
  if [ $r -ne 0 ];then
    echo ""
    echo "  Query failed, code: "$r;
    echo ""
    echo "Data:"
    echo "$data" | jq '.' | tr "^" "'"
    exit 1
  fi

  iniQ '.query'                    && query=$r
  iniQ '.translation | .[0]'       && translation=$r

  iniQ '.basic? | .phonetic?'      && ph="["$(echo $r | tr "^" "'" | sed 's/\"//g')"]"
  iniQ '.basic? | ."us-phonetic"?' && usph="["$(echo $r | tr "^" "'" | sed 's/\"//g')"]"
  iniQ '.basic? | ."uk-phonetic"?' && ukph="["$(echo $r | tr "^" "'" | sed 's/\"//g')"]"
  echo ""
  printf "\e[1m::$query\e[3m  " | sed 's/\"//g'
  phF=0
  [ "$ph"x   != "[null]"x ] && printf "$ph" && phF=1
  if [ "$usph"x != "[null]"x ];then
    [ $phF -eq 1 ] && printf ", " || phF=1
    printf "US:$usph"
  fi
  if [ "$ukph"x != "[null]"x ];then
    [ $phF -eq 1 ] && printf ", " || phF=1
    printf "UK:$ukph"
  fi
  echo -e "\e[0m"
  echo ""
  echo "  $translation  " | sed 's/\"//g'
  echo "---------------------------------------------"

  declare -a explainsArray
  iniQ '.basic? | .explains?' && eval "longStrFac '$(echo $r)' 'explainsArray'"
  eaNum=1
  for var in ${explainsArray[*]};do
    varFor=$(echo $var | tr "_" " " | tr "^" "'")
    echo -e "\e[1m  $eaNum". "$varFor\e[0m"
    eaNum=$(($eaNum + 1))
  done

  echo ""
  iniQ '.web'                      && webArray=$r
  loop=0
  while [ $loop -ge 0 ];do
    webR=$(eval "echo '$webArray' | jq '.[$loop]?'")
    if [ "$webR"x == "null"x ];then
      loop=-1
    else
      name=$(echo $webR | jq '.key' | sed 's/\"//g')
      declare -a webA
      eval "longStrFac '$(echo $webR | jq '.value')' 'webA'"
      if [ $loop -eq 0 ];then
        echo "  网络释义："
        for var in ${webA[*]};do
          varFor="$(echo $var | tr '_' ' ')"
          printf "    $varFor\n"
        done
        echo ""
      else
        [ $loop -eq 1 ] && echo "  短语："
        printf "    $name: "
        for var in ${webA[*]};do
          varFor="$(echo $var | tr '_' ' ' | tr "^" "'")"
          printf "$varFor; "
        done
        echo ""
      fi
      loop=$(($loop + 1))
    fi
  done
  echo ""
  echo ""
}

tranStr=$1
if [ "$tranStr"x == ""x ];then
  clear
  while true;do
    read -e -p $'\e[4m\e[3m\e[1mEnter a word or phrase:\e[0m ' tranStr
    [ "$tranStr"x == ""x ] && eval "$blackCharOpt"
    history -s "$tranStr"
#  while read -e -r -p "> " tranStr;do
    main
  done
  exit 0
fi
wordLong=2
while [ $wordLong -gt 0 ];do
  if [ $wordLong -gt 9 ];then
    wordLong=-1
    printf "\e[1m!Err.\nSorry, the input sentence is too long.\nThey need to be quoted or paste here\e[0m.\n\n>> "
    read tranStr
    continue
  fi
  eval "tranWord=\$$wordLong"
  if [ "$tranWord"x == ""x ];then
    wordLong=-1
  else
    tranStr=$tranStr" "$tranWord
    wordLong=$(($wordLong + 1))
  fi
done
main

