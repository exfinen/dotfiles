#!/bin/bash

SCRIPT_DIR=$(cd $(dirname $0); pwd)

cd $SCRIPT_DIR

FILES=`ls -d .??*`

for file in $FILES; do
  [ "$file" = '.git' ] && continue

  SYMLINK=~/$file

  if [ ! -e $SYMLINK ]; then
    ln -s $SCRIPT_DIR/$file $SYMLINK
    echo -n "Symlinked '$file' to '$SYMLINK'... "
  fi
done

if [ ! -e ~/.ssh ]; then
  mkdir ~/.ssh
  chmod 700 ~/.ssh
fi

if [ ! -e ~/.ssh/config ]; then
  ln -s $SCRIPT_DIR/config ~/.ssh/config 
  echo "Symlinked .ssh/config to '$SCRIPT_DIR/config'"
fi

if [ ! -e ~/.ssh/keys/github ]; then
  mkdir -p ~/.ssh/keys/github

  pushd ~/.ssh/keys/github
  touch id_rsa
  chmod 600 id_rsa
  touch id_rsa.pub
  chmod 644 id_rsa.pub
  popd
  echo "Created github key entries"
fi

