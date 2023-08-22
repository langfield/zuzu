#!/bin/bash
STREAMS=$(curl https://leanprover-community.github.io/archive/ | sed '/href="stream/!d' | sed 's/^    <p><a href="/https:\/\/leanprover-community.github.io\/archive\//g' | sed 's/".\+$//g')
STREAMS=$(echo "$STREAMS" | head -n 1)
rm -rf out
mkdir out
xargs -0 -I{} ./dl.sh {} < <(echo "$STREAMS" | tr \\n \\0)
