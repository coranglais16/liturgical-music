#!/usr/bin/env bash

# this script reads from a tab-delimited file 'data.tsv'
# with information in six columns:
# filepath, title, composer, genre, voicing, sort key
# and sends the output to update-database.sh

while IFS=$'\t' read -r col1 col2 col3 col4 col5 col6; do
    ./update-database.sh "$col1" "$col2" "$col3" "$col4" "$col5" "$col6"
done < data.tsv