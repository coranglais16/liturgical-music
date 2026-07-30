#!/usr/bin/env bash

## this script returns any record in the database that has a key a missing value

yqOutput=$(yq '.[] | select(.[] == null or .[] == "")' docs/_data/database.yml)

if [[ -z "$yqOutput" ]]; then
	echo 'No empty keys!'
	exit 0
else
	echo "$yqOutput"
	exit 1
fi