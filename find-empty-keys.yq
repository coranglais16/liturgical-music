!#/usr/bin/env bash

## this script returns any record in the database that has a key a missing value

yq '.[] | select(.[] == null or .[] == "")' docs/_data/database.yml