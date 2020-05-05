import pyodbc, csv, sys

# Loads the geocode latitude/longitude to the NPPES database for
# business addresses that have been geocoded using the Census
# geocoding system.

inputfile = sys.argv[1]
userid = sys.argv[2]
password = sys.argv[3]
server = sys.argv[4]
writecount, readcount, fldnum = 0, 0, 0

connstr = f'Driver=ODBC Driver 17 for SQL Server;Server={server};UID={userid};PWD={password};Database=NPPES;'

sqlinsert1 = """
insert into dbo.npigeo(
NPI, 
Matchflag,
Matchtype,
Longitude,
Latitude
)
values (?, ?, ?, ?, ?)
"""


print("Input File :", inputfile)
conn = pyodbc.connect(connstr)
cursor = conn.cursor()

with open(inputfile, encoding="utf8", errors='replace', mode='r') as csvinfile:
	datareader = csv.reader(csvinfile, delimiter=',')
	for row in datareader:
		readcount += 1
		if row[2] == "Match":
			longlat = row[5].split(',')  
			Longitude, Latitude = float(longlat[0]), float(longlat[1])
			dbrec = [row[0], row[2], row[3], Longitude, Latitude]
		else:
			dbrec = [row[0], row[2], None, None, None]
		cursor.execute(sqlinsert1, dbrec)
		if readcount % 1000 == 0:
			print("Records Processed:", readcount)
			conn.commit()
conn.commit()
conn.close()
print("Records read:   ", readcount)
