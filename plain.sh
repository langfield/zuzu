#!/bin/bash

dump () {
  basename=$(echo "$1" | sed 's/^.\+\///g' | sed 's/.html$//g' | sed 's/^-\+//g' | sed 's/(//g' | sed 's/)//g')
  filename="txt/$basename.txt"
  lynx --dump $1 > $filename
  sed -i '/https:\/\/leanprover-community\.github\.io\/archive\/stream.\+\.html#[0-9]\+/d' $filename
  sed -i '/Hidden links:/,$d' $filename
}

rm -rf txt
mkdir txt
sources=$(find -iname "*.html" | sed 's/(/\\\\(/g' | sed 's/)/\\\\)/g' | sed "s,',\\\\\\\\\\\',g")
export -f dump
xargs -t -I{} bash -c "dump {}" < <(echo "$sources")
