#!/bin/bash

set -e

for dir in */ ; do
  echo "Procesando directorio: $dir"
  cd $dir
  echo "En directorio `pwd`"
  bundle install
  bundle exec rake
  cd ..
done
