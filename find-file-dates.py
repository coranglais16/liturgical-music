from pathlib import Path
from datetime import datetime
import subprocess
import re

directory = Path('docs/assets/pdf')
pattern = 'Date:\\s+\\w+\\s+(\\w+)\\s+(\\d+)\\s+\\d+:\\d+:\\d+\\s+(\\d{4})'

# loop through all the PDF files and run 'git log' on each one
for file in directory.iterdir():
	result = subprocess.run(
		["git", "log", "--diff-filter=A", "--", str(file)],
		capture_output=True,
		text=True
  )

	# run the regex on the 'git log' to extract just the date
	res = re.search(pattern, result.stdout)
	if res:
		text = f"{res.group(1)} {res.group(2)} {res.group(3)}"
	
		# convert the string to a datetime object
		date = datetime.strptime(text, "%b %d %Y")
		
		# reorder the datetime object to yyyy-mm-dd format
		result = date.strftime("%Y-%m-%d")
		
		print(result)