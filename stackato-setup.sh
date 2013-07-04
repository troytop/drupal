#!/bin/bash
echo "This script does Stackato setup related to filesystem."


if ! [ -s $STACKATO_FILESYSTEM/files]
  then
    # create folders in the shared filesystem 
    mkdir -p $STACKATO_FILESYSTEM/files
fi

echo "Symlink to folders in shared filesystem..."
rm -fr sites/default/files
ln -s $STACKATO_FILESYSTEM/files sites/default/files

echo "All Done!"
