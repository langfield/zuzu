#!/bin/bash
BASEURL=$(echo $1 | sed 's/\/index.html$//g')
URLS=$(curl -s $1 | sed '/href="topic/!d' | sed 's/^  <li><a href="//g' | sed 's/".\+$//g' | sed "s/'/\\\\'/g")
TOPIC=$(echo $1 | sed 's/^.\+\/stream\/[0-9]\+-//g' | sed 's/\/[^\/]\+$//g' | sed 's/-\/-/-/g')
mkdir out/$TOPIC
cd out/$TOPIC
echo "$URLS" | xargs -I{} wget $BASEURL/{}
echo "$URLS"
