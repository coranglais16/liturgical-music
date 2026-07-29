from pathlib import Path
from datetime import datetime
import subprocess
import re

database = Path('docs/_data/database.yml')
pdfDirectory = Path('docs/assets/pdf')

# read the database as plain text
text = database.read_text()

# split into individual YAML records
records = text.split("\n- ")

new_records = [] # initialize an empty array to hold the new records

for record in records:

	# get the path from the record
	match = re.search(r"^(- )?path:\s*(.+)$", record, re.MULTILINE)

	if not match: # no path in the record
		new_records.append(record) # stick the record as is back into the array
		continue

	# there's a path in the record
	yaml_path = match.group(2).strip() # strip the match down to just the path

	# add the docs directory onto the front of the path
	file = Path("docs" + yaml_path)

	# run 'git log' on the filepath
	gitLog = subprocess.run(
		["git", "log", "--diff-filter=A", "--format=%ad", "--date=format:%b %d %Y", "--", str(file)],
		capture_output=True,
		text=True
  )

	# read the date from STDOUT
	gitDate = re.search(r"(\w+ \d+ \d{4})", gitLog.stdout)

	if gitDate: # there's a date in the 'git log' output

		# convert the string to a datetime object
		dateString = datetime.strptime(gitDate.group(1), "%b %d %Y")

		# reorder the datetime object to yyyy-mm-dd format
		ymdDate = dateString.strftime("%Y-%m-%d")

		# add the date if the record doesn't already have one
		if not re.search(r"^date:", record, re.MULTILINE):
			record = record.rstrip() + f"\n  date: {ymdDate}"
			print(yaml_path, ymdDate)

	# add the record with the date into the array
	new_records.append(record)

# put the records back together
output = "\n- ".join(new_records)

# write the modified YAML
database.write_text(output)
		
	# else: # no date in the 'git log' output, such as .DS_Store
	# 	continue