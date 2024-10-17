#!/bin/sh

echo "~~~~~~~~~~ TESTING ~~~~~~~~~~"
DIR="test"
BASEDIR=$PWD
ls -d */ | sort -V | while read -r PROB; do
    cd $BASEDIR/$PROB && (ls | grep -E "(tas|qlock).maude" | sort -V) | while read -r FILE; do
        NAME=`echo $FILE | cut -d '.' -f1`
        echo "--> $NAME"
        maude < $FILE -no-banner | sed -r '/^(rewrites:|Solution|states:)/d' > "$DIR/$NAME.out"
        diff "$DIR/$NAME.expected" "$DIR/$NAME.out"
        rm "$DIR/$NAME.out"
    done
done
echo "DONE!"