#!/usr/bin/env bash

yaml_file=database.yml
path="$1"
title="$2"
composer="$3"
genre="$4"
voicing="$5"
sort="$6"

if [ -z "$1" ]; then
  echo "Usage: $0 PATH TITLE COMPOSER GENRE VOICING SORT"
  exit 1
fi

echo "-" >> $yaml_file
echo "  path: $1" >> $yaml_file
echo "  title: $2" >> $yaml_file
echo "  composer: $3" >> $yaml_file
echo "  genre: $4" >> $yaml_file
echo "  voicing: $5" >> $yaml_file
echo "  sort: $6" >> $yaml_file

# now sort the database file by composer's last name, then title
yq -i 'sort_by(.sort, .title)' $yaml_file