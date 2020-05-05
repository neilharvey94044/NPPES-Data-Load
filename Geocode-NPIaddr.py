import pyodbc, csv, sys, requests

# Python program to extract addresses from the NPI data and geocode them.
# This data will be submitted in 10,000 row batches to the U.S. Census
# GeoCoding API, the purpose being to obtain Latitude and Longitude for
# each NPI's place of business.
# A temporary file will contain the NPI addresses during processing.
# A checkpoint file will retain the last NPI processed and used to determine the next 
# 10,000 record chunk. Goecoded results will be appended to a single file.

#userid = sys.argv[1]
#password = sys.argv[2]
#server = sys.argv[3]

userid = 'sa'
password = 'Bracket4Tree@'
server = '127.0.0.1'
connstr = f'Driver=ODBC Driver 17 for SQL Server;Server={server};UID={userid};PWD={password};Database=NPPES;'


def get10kBlock(connstr, outfile, checkpoint):
	print('get10kBlock')

	newcheckpoint = checkpoint
	# SQL to get block of NPI records, starting after checkpoint value
	sqlextract = """
	Select TOP(1000)
	NPI,
	Provider_First_Line_Business_Practice_Location_Address,
	Provider_Business_Practice_Location_Address_City_Name,
	Provider_Business_Practice_Location_Address_State_Name,
	Provider_Business_Practice_Location_Address_Postal_Code
	From [dbo].[npidata] as npi
	Where npi.NPI > ?
	Order by npi.NPI
	;
	"""


	conn = pyodbc.connect(connstr)
	cursor = conn.cursor()

	cursor.execute(sqlextract, checkpoint)
	with open(outfile, mode='w', newline='') as csvoutfile:
		datawriter = csv.writer(csvoutfile, delimiter=',', quoting=csv.QUOTE_NONE, escapechar='\\')
		for row in cursor.fetchall():
			datawriter.writerow(row)
		if cursor.rowcount == 0:
			newcheckpoint = -1	
		else:
			newcheckpoint = row[0]
	conn.commit()
	conn.close()
	return newcheckpoint


def geocodeBlock(infile, outfile):
	print('geocodBlock')

	url = 'https://geocoding.geo.census.gov/geocoder/locations/addressbatch'

	files = {'addressFile': open(infile,'rb')}
	values = {'benchmark': 'Public_AR_Current'}

	r = requests.post(url, files=files, data=values)

	with open(outfile, 'ab') as fd:
		for chunk in r.iter_content(chunk_size=128):
			fd.write(chunk)

def writeCheckpoint(checkpoint):
	print('writeCheckpoint')
	with open('CHECKPOINT.txt', 'w') as fd:
		fd.write(str(checkpoint))



###################
# Main()
###################

startpoint = 1861880619
tempfile = 'tempblock.csv'
geocodedfile = 'geocodedNPI.csv'
writeCheckpoint(startpoint)	
loops = 1

while startpoint >= 0:
	print("startpoint:", startpoint, "loop:", loops)
	startpoint = get10kBlock(connstr, tempfile, startpoint)
	print(startpoint)
	geocodeBlock(tempfile, geocodedfile) 
	writeCheckpoint(startpoint)	
	loops += 1
	

