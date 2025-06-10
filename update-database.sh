#!/usr/bin/env bash

yaml_file=docs/_data/database.yml
title="$2"
composer="$3"
genre="$4"
voicing="$5"
path="$1"

if [ -z "$1" ]; then
  echo "Usage: $0 TITLE COMPOSER GENRE VOICING PATH"
  exit 1
fi

echo "" >> $yaml_file
echo "-" >> $yaml_file
echo "  path: $1" >> $yaml_file
echo "  title: $2" >> $yaml_file
echo "  composer: $3" >> $yaml_file
echo "  genre: $4" >> $yaml_file
echo "  voicing: $5" >> $yaml_file