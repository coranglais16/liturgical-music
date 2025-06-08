#!/usr/bin/env bash

yaml_file=docs/_data/testdb.yml
title="$1"
composer="$2"
genre="$3"
voicing="$4"
path="$5"

if [ -z "$1" ]; then
  echo "Usage: $0 TITLE COMPOSER GENRE VOICING PATH"
  exit 1
fi

echo "" >> $yaml_file
echo "-" >> $yaml_file
echo "  path: $5" >> $yaml_file
echo "  title: $1" >> $yaml_file
echo "  composer: $2" >> $yaml_file
echo "  genre: $3" >> $yaml_file
echo "  voicing: $4" >> $yaml_file