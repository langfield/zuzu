echo "$1"
BASENAME=$(echo "$1" | sed 's/^.\+\///g' | sed 's/.html$//g' | sed 's/^-\+//g' | sed 's/(//g' | sed 's/)//g')
FILENAME="txt/$BASENAME.txt"
lynx --dump $1 > $FILENAME
sed -i '/https:\/\/leanprover-community\.github\.io\/archive\/stream.\+\.html#[0-9]\+/d' $FILENAME
sed -i '/Hidden links:/,$d' $FILENAME
