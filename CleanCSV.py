import csv, sys

# This script filters a csv file by the value in a specified column.
# The output file does not quote columns and uses the pipe delimiter.
# Command line as follows:
# python CleanCSV.py <input file name> <output file name> <col number> <filter value>
#TODO: make filtering optional


inputfile, outputfile = sys.argv[1], sys.argv[2]
if len(sys.argv) > 3:
	filtercol=(int) (sys.argv[3])
	filterval=sys.argv[4]
	filter=True
else:
	filtercol = 0
	filterval = '*'
	filter = False

writecount, readcount, fldnum = 0, 0, 0

print("NPI Input File      :", inputfile)
print("Temp NPI Output File:", outputfile)

with open(inputfile, mode='r') as csvinfile, \
	 open(outputfile, mode='w', newline='') as csvoutfile:
	datawriter = csv.writer(csvoutfile, delimiter='|', quoting=csv.QUOTE_NONE)
	datareader = csv.reader(csvinfile)
	for row in datareader:
		readcount += 1
		if readcount == 1: # skip the header record
			continue
		elif readcount % 100000 == 0:
			print("Records read:   ", readcount, "\nRecords written:", writecount)
		elif filter: 
			if (row[filtercol] == filterval):
				datawriter.writerow(row)
				writecount += 1
		else:
			datawriter.writerow(row)
			writecount += 1
