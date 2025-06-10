#!/usr/bin/env bash

while IFS=$'\t' read -r col1 col2 col3 col4 col5; do
    ./update-database.sh "$col1" "$col2" "$col3" "$col4" "$col5"
done < data.tsv