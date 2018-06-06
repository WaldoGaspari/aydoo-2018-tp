#!/bin/bash

set -e

for dir in */ ; do
  cd $dir
  if [ -f Rakefile ]
  then
    bundle install
    bundle exec rake
  fi
  cd ..
done
