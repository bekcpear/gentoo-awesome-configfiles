#!/bin/bash
#
# Created by Bekcpear on 22 Nov, 2016

packageUseDir="/etc/portage/package.use"
declare -a commentResultArr

if [ "$1"x == ""x ]; then
  echo "Usage: $0 package [--show-comment] [--single]";
  exit 1;
fi

commentOpt=0
singleMod=0

function setOpt(){
  local opt=$1
  if [ "$opt" == "--show-comment" ];then
    commentOpt=1
  elif [ "$opt" == "--single" ];then
    singleMod=1
  else
    echo "Usage: $0 package [--show-comment] [--single]";
    exit 1;
  fi
}

if [ "$2"x != ""x ]; then
  setOpt $2
fi
if [ "$3"x != ""x ]; then
  setOpt $3
fi

echo "";


function getComments(){
  local filePath=$1
  local lineNum=$2
  unset commentResultArr

  local flag=0
  while [ $flag -ge 0 ];do
    local needNum=$(($lineNum - $flag - 1))
    if [ $needNum -lt 1 ];then
      flag=-1
    else
      local str=$(sed -n "$needNum""p" $filePath | egrep "^#")
      if [ "$str"x != ""x ];then
        str=$(echo $str | tr " " "!")
        commentResultArr[$flag]="$str"
        flag=$(($flag + 1))
      else
        flag=-1
      fi
    fi
  done
}

function show(){
  local i=$1
  result=$(egrep --line-number "^[->=/0-9a-z. ]*$i" $packageUseDir/*)
  if [ "$result"x != ""x ]; then
    echo -e " * \e[1;32m"$i"\e[0m"
    rLines=$(echo $result | sed 's/\/etc/\n\/etc/g' | sed '/^$/d' | wc -l)
    filePath=""
    for j in $(seq 0 $(($rLines -1)));
    do
      b[$j]=$(echo $result | sed 's/\/etc/\n\/etc/g' | sed '/^$/d' | sed -n "$(($j+1))p")
      bSub=(${b[$j]})
      filePathTmp=$(echo ${bSub[0]} | awk -F ':' '{print $1}');
      lineNum=$(echo ${bSub[0]} | awk -F ':' '{print $2}');
      if [ "$filePath"x != "$filePathTmp"x ]; then
        filePath=$filePathTmp;
        echo -e ' `-- \e[0;32m'$filePath'\e[0m';
      fi
      if [ $commentOpt -eq 1 ];then
        getComments $filePath $lineNum
        for comment in ${commentResultArr[*]};
        do
          echo -e '   `-- \e[1;36m'$comment'\e[0m' | tr "!" " "
        done
      fi
      packageName=$(echo ${bSub[0]} | awk -F ':' '{print $3}');
      printf '   `-- \e[1;37m'$packageName' '
      bSubLength=${#bSub[*]}
      if [ $bSubLength -gt 2 ];then
        for x in $(seq 1 $(($bSubLength -1 )));
        do
          printf ' \e[1;35m'${bSub[$x]}'\e[0m'
        done
        echo ""
      else
        echo -e ' \e[1;35m'${bSub[1]}'\e[0m'
      fi
    done

    echo "";
  fi
}

if [ $singleMod -eq 1 ];then
  show $1
else
  deps=$(equery g $1) 
  if [ $? -ne 0 ]; then
    echo "Error: package does not exist."
    exit 1;
  fi
  a=($(echo $deps | sed 's/00m\s\+/\n/g' | sed '/^$/d' | awk -F";" '{printf $2}" "' | tr " " "!" | awk -F ']_' '{printf $1" "}'))
  for i in ${a[*]};
  do
    flagStr=$(echo $i | grep '!0')
    if [ "$flagStr"x != ""x ]; then
      echo "================================="
      echo "= "$(echo $flagStr | awk -F '/' '{printf substr($1,4)"/"$3}' | awk -F ':' '{print $1}')
      echo "================================="
    else
      packageNameT=$(echo $i | awk -F '-[0-9]' '{printf substr($1,4)" "}')
      show $packageNameT
    fi
  done
fi
