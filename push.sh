#!/bin/bash
#

read -r -e -p "Changes: " changes

git add .
eval "git commit -m '$changes'"
http_proxy="ugt:8123" git push
