# this script takes a list of filepaths from macOS and separates it into lines of text

import sys

stdin = sys.stdin.read().rstrip() # read from STDIN and remove the trailing newline

# strip the leading and trailing quotes
# and replace the internal separators (' ') with newlines
parts = stdin.strip("'").replace("' '", '\n')

print(parts)