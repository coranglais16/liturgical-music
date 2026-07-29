#!/usr/bin/env bash

# This script reads from a tab-delimited file passed as $1.
# The file must be formatted with information in six columns:
### filepath (beginning at assets/pdf/), title, composer, genre, voicing, sort key
# Then it builds a YAML record out of each set of six columns and adds it to docs/_data/database.yml.
# Then it sorts the database by the sort key and the title.
# Finally it updates the build date for the website.

# Usage: ./update-database.sh FILENAME.tsv

# if there's no file passed to the script, then fail
if [[ -z "$1" ]]; then
  echo "Usage: ./update-database.sh FILENAME.tsv"
  exit 1
fi

yaml_file=docs/_data/database.yml
input_file=$1
num_added=0

if ! [[ $(tail -c1 "$input_file" | wc -l) -gt 0 ]]; then # file does not end in a newline, so add one
	echo "" >> $input_file
fi

while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6; do
	# assign the variables
	path="$col1"
	title="$col2"
	composer="$col3"
	genre="$col4"
	voicing="$col5"
	sort="$col6"
	today=$(date '+%Y-%m-%d') # today's date

	# build the YAML record
	echo "-" >> $yaml_file
	echo "  path: $path" >> $yaml_file
	echo "  title: $title" >> $yaml_file
	echo "  composer: $composer" >> $yaml_file
	echo "  genre: $genre" >> $yaml_file
	echo "  voicing: $voicing" >> $yaml_file
	echo "  sort: $sort" >> $yaml_file
	echo "  date: $today" >> $yaml_file # date added is today's date
	
	num_added=$((++num_added))
done < $input_file

if [[ $num_added=1 ]]; then
	plural='motet'
elif [[ $num_added>1 || $num_added=0 ]]; then
	plural='motets'
fi

echo "$num_added $plural added to the database."

# sort the database file by composer's last name, then title
yq -i 'sort_by(.sort, .title)' $yaml_file

# update the build date
echo "last-build: $today" > docs/_data/build.yml
