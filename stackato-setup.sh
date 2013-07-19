#!/bin/bash
echo "Setting up the filesystem."
echo $STACKATO_FILESYSTEM

if ! [ -e $STACKATO_FILESYSTEM/all/themes/README.txt]
  then
    echo "No Drupal files in $STACKATO_FILESYSTEM."
    echo "Copying pushed directories and symlinking..."
    mkdir -p $STACKATO_FILESYSTEM/all $STACKATO_FILESYSTEM/files
    cp -r sites/all/* $STACKATO_FILESYSTEM/all
    rm -rf sites/all
    ln -s $STACKATO_FILESYSTEM/all sites/all 
    cp -r sites/default/files $STACKATO_FILESYSTEM/
    rm -rf sites/default/files
    ln -s $STACKATO_FILESYSTEM/files sites/default/files 
    echo "Finished moving and symlinking"
  else
    echo "Persistent Drupal files found. Removing ephemeral dirs and symlinking..."
    rm -rf sites/all
    ln -s $STACKATO_FILESYSTEM/all sites/all 
    rm -rf sites/default/files
    ln -s $STACKATO_FILESYSTEM/files sites/default/files 
    echo "Finished deleting and symlinking"
fi

