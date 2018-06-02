#!/bin/bash

set -e

for dir in */ ; do
  cd $dir
  bundle install
  bundle exec rake
  cd ..
done
