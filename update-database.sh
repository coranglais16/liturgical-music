#!/usr/bin/env bash

# Usage: ./update-database.sh FILENAME.tsv

# This script reads from a tab-delimited file passed as $1.
# The file must be formatted with information in six columns:
### filepath (beginning at assets/pdf/), title, composer, genre, voicing, sort key
# First, the script moves each file from
### '/Users/jonathan/Documents/Choral music/ Add to Liturgical Music Repo'
### to docs/assets/pdf.
# Then it builds a YAML record out of each set of six columns.
# In so doing, it updates the value of the 'path' key to begin with docs/assets/pdf.
# The YAML record includes a seventh key, the date added, which is set to today's date.
# It adds the YAML record to docs/_data/database.yml.
# Then it sorts the database by the sort key and the title.
# Finally it updates the build date for the website.

# if there's no file passed to the script, then fail
if [[ -z "$1" ]]; then
	echo "Usage: ./update-database.sh FILENAME.tsv"
	exit 1
fi

# if the file is empty, then fail
if [[ ! -s "$1" ]]; then
	echo "Empty file!"
	exit 1
fi

# initialize variables
yaml_file=docs/_data/database.yml
input_file=$1
num_added=0
old_dir=/Users/jonathan/Documents/Choral\ music/\ Add\ to\ Liturgical\ Music\ Repo
new_dir=docs/assets/pdf

# move each file from Add to Liturgical Music Repo to /docs/assets/pdf
for file in "$old_dir"/*; do
	mv "$file" "$new_dir"
done

# add newline to end of .tsv file if missing
if ! [[ $(tail -c1 "$input_file" | wc -l) -gt 0 ]]; then
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
	
	# change prefix of path to docs/assets/pdf
	new_path="$new_dir/${path##*/}"

	# build the YAML record
	echo "-" >> $yaml_file
	echo "  path: $path" >> $yaml_file
	echo "  title: $title" >> $yaml_file
	echo "  composer: $composer" >> $yaml_file
	echo "  genre: $genre" >> $yaml_file
	echo "  voicing: $voicing" >> $yaml_file
	echo "  sort: $sort" >> $yaml_file
	echo "  date: $today" >> $yaml_file # date added is today's date
	
	# increment the number of motets added
	num_added=$((++num_added))
done < $input_file

# grammar check for reporting how many motets were added
if [[ $num_added -eq 1 ]]; then
	plural='motet'
else
	plural='motets'
fi

# report on how many motets were added
echo "$num_added $plural added to the database."

# sort the database file by composer's last name, then title
yq -i 'sort_by(.sort, .title)' $yaml_file

# update the build date
echo "last-build: $today" > docs/_data/build.yml
