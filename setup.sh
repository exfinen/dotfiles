#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

cd $SCRIPT_DIR

FILES=`ls -d .??*`

for file in $FILES; do
  [ "$file" = '.git' ] && continue

  SYMLINK=~/$file
  echo -n "Symlinking '$file' to '$SYMLINK'... "

  if [ ! -e $SYMLINK ]; then
    ln -s $SCRIPT_DIR/$file $SYMLINK
    echo "done."
  else
    echo "already exists."
  fi
done

