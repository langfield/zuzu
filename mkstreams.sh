#!/bin/bash

dl () {
  BASEURL=$(echo $1 | sed 's/\/index.html$//g')
  URLS=$( curl -s $1 \
          | sed '/href="topic/!d' \
          | sed 's/^  <li><a href="//g' \
          | sed 's/".\+$//g' \
          | sed "s/'/\\\\'/g" \
          | sed "s,^,$BASEURL/,g")
  TOPIC=$(echo $1 \
          | sed 's/^.\+\/stream\/[0-9]\+-//g' \
          | sed 's/\/[^\/]\+$//g' \
          | sed 's/-\/-/-/g')
  mkdir out/$TOPIC
  cd out/$TOPIC
  echo "$URLS" | xargs -P 0 -I{} wget {}
}

STREAMS=$(curl https://leanprover-community.github.io/archive/ \
          | sed '/href="stream/!d' \
          | sed 's/^    <p><a href="/https:\/\/leanprover-community.github.io\/archive\//g' \
          | sed 's/".\+$//g' \
          | head -n 1)
rm -rf out
mkdir out
export -f dl
xargs -0 -I{} bash -c "dl {}" < <(echo "$STREAMS" | tr \\n \\0)
