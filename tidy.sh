rm -rf txt
mkdir txt
SOURCES=$(find -iname "*.html" | sed 's/(/\\\\(/g' | sed 's/)/\\\\)/g')
echo "$SOURCES"
xargs -I{} bash -c "./dump.sh {}" < <(echo "$SOURCES")
