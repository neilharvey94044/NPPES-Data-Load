import pyodbc, csv, sys

# Loads the geocode latitude/longitude to the NPPES database by
# zip code. These will be used for a best effort approach 
# to geocode those NPI addresses that received a "No_Match" 
# status from the Census geocoding system. It's far from accurate, 
# but provides a facsimile that is close enough for my purpose.

inputfile = sys.argv[1]
userid = sys.argv[2]
password = sys.argv[3]
server = sys.argv[4]
writecount, readcount, fldnum = 0, 0, 0

connstr = f'Driver=ODBC Driver 17 for SQL Server;Server={server};UID={userid};PWD={password};Database=NPPES;'

sqlinsert1 = """
insert into dbo.zipgeo(
Zip, 
City,
State,
Latitude,
Longitude,
Timezone
)
values (?, ?, ?, ?, ?, ?)
"""


print("Input File :", inputfile)
conn = pyodbc.connect(connstr)
cursor = conn.cursor()

with open(inputfile, encoding="utf8", errors='replace', mode='r') as csvinfile:
	datareader = csv.reader(csvinfile, delimiter=';')
	for row in datareader:
		readcount += 1
		if readcount == 1:
			continue   # skip header record
		dbrec = [row[0], row[1], row[2], float(row[3]), float(row[4]), int(row[5])]
		cursor.execute(sqlinsert1, dbrec)
		if readcount % 1000 == 0:
			print("Records Processed:", readcount)
			conn.commit()
conn.commit()
conn.close()
print("Records read:   ", readcount)
