import pyodbc, csv, sys, requests

# Python program to extract addresses from the NPI data and geocode them.
# This program submits a single address to the Census geocoder at a time,
# it does not bulk upload files of addresses for geocoding.

#userid = sys.argv[1]
#password = sys.argv[2]
#server = sys.argv[3]

userid = 'sa'
password = 'Bracket4Tree@'
server = '127.0.0.1'
connstr = f'Driver=ODBC Driver 17 for SQL Server;Server={server};UID={userid};PWD={password};Database=NPPES;'


sqlupdate= """
Update [dbo].[npigeo]
Set Latitude = ?, Longitude = ?
Where NPI = ?
;
"""

# SQL to get block of NPI records, starting after checkpoint value
sqlextract = """
Select 
npi.NPI,
Provider_First_Line_Business_Practice_Location_Address,
Provider_Second_Line_Business_Practice_Location_Address,
Provider_Business_Practice_Location_Address_City_Name,
Provider_Business_Practice_Location_Address_State_Name,
Provider_Business_Practice_Location_Address_Postal_Code
From [dbo].[npidata] as npi, [dbo].[npigeo] as geo
Where geo.NPI = npi.NPI and geo.Matchflag IN ('Tie')
	and geo.Latitude IS NULL
;
	"""

def formatAddr(row):
	#address =  str(row[1]) + '%2C' + str(row[2] or '') + \
	address =  str(row[1]) + \
	'%2C' + str(row[3]) + '%2C' + str(row[4]) + ' ' + str(row[5])
	address.replace(' ', '+')
	return address
	 
url = 'https://geocoding.geo.census.gov/geocoder/locations/onelineaddress'

updateconn = pyodbc.connect(connstr)
updcurs = updateconn.cursor()
conn = pyodbc.connect(connstr)
cursor = conn.cursor()
cursor.execute(sqlextract)

for row in cursor.fetchall():
	print(row)
	values = {'benchmark': 'Public_AR_Current',
		'vintage': 'Current_Current',
		'address': formatAddr(row),
		'format': 'json'
		}
	r = requests.get(url, params=values)
	jo = r.json()
	if len(jo.get('result').get('addressMatches')) > 0:
		longitude = jo.get('result').get('addressMatches')[0].get('coordinates').get('x')
		latitude  = jo.get('result').get('addressMatches')[0].get('coordinates').get('y')
		npistr    = str(row[0])
		print("NPI:", npistr, "latitude:", latitude, "longitude:", longitude)
		params = [latitude, longitude, npistr]
		updcurs.execute(sqlupdate, params)
		updateconn.commit()
		
updateconn.close()
conn.commit()
conn.close()

