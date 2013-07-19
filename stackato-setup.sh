#!/bin/bash
echo "Setting up the filesystem."
echo $STACKATO_FILESYSTEM

if [ -d $STACKATO_FILESYSTEM ]
  then
    echo "Found a persistent filesystem"
    if ! [ -d $STACKATO_FILESYSTEM/files ]
      then
        echo "No Drupal files in $STACKATO_FILESYSTEM."
        echo "Creating directory and symlinking..."
        mkdir -p $STACKATO_FILESYSTEM/files
        ln -s $STACKATO_FILESYSTEM/files sites/default/files 
        echo "Finished moving and symlinking"
      else
        echo "Persistent Drupal files found. Symlinking..."
        ln -s $STACKATO_FILESYSTEM/files sites/default/files 
        echo "Finished deleting and symlinking"
    fi
  else
    echo "No persistent filesystem found, using ephemeral disk."
    echo "Warning: user content will be lost on restart."
fi
