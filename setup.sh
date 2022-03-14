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

if [ ! -e ~/.ssh ]; then
  mkdir ~/.ssh
  chmod 700 ~/.ssh
  ln -s $SCRIPT_DIR/config ~/.ssh/config 
  mkdir -p ~/.ssh/keys/github

  pushd ~/.ssh/keys/github
  touch id_rsa
  chmod 600 id_rsa
  touch id_rsa.pub
  chmod 644 id_rsa.pub
  popd
fi
