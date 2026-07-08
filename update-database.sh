#!/usr/bin/env bash

# this script takes six columns of input processed by run-script.sh
# and builds a YAML record out of each set of six columns.
# then it sorts the resulting file by the sort key and the title

# define the variables
yaml_file=docs/_data/database.yml
path="$1"
title="$2"
composer="$3"
genre="$4"
voicing="$5"
sort="$6"

# if there's no data passed to the script, then fail
if [ -z "$1" ]; then
  echo "Usage: $0 PATH TITLE COMPOSER GENRE VOICING SORT"
  exit 1
fi

# build the YAML record
echo "-" >> $yaml_file
echo "  path: $1" >> $yaml_file
echo "  title: $2" >> $yaml_file
echo "  composer: $3" >> $yaml_file
echo "  genre: $4" >> $yaml_file
echo "  voicing: $5" >> $yaml_file
echo "  sort: $6" >> $yaml_file

# sort the database file by composer's last name, then title
yq -i 'sort_by(.sort, .title)' $yaml_file