#!/bin/bash
#

read -r -e -p "Input what changed: " changes

git add .
git status
eval "git commit -m '$changes'"
http_proxy="ugt:8123" git push
[ $? -eq 0 ] && echo "Done."
