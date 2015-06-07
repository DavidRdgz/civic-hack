#!/bin/bash
# EXAMPLE 013000 2012
#B19013_001E = median income 
#B01003_001E = population
TRACT=$1
YEAR=$2
curl 'http://api.census.gov/data/'$YEAR'/acs5?get=NAME,B19013_001E,B01003_001E&for=tract:'$TRACT'&in=county:075+state:06&key=102696faa260055c3afd70973f71ddaab64ac6ba' -H 'Origin: null' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'Content-Type: text/plain' -H 'Accept: text/plain, */*; q=0.01' -H 'Connection: keep-alive'  --compressed
#curl 'http://api.census.gov/data/'$YEAR'/acs5?get=NAME,B19013_001E,B01003_001E&for=tract:'$TRACT'&in=county:075+state:06&key=102696faa260055c3afd70973f71ddaab64ac6ba' -H 'Origin: null' -H 'Accept-Encoding: gzip, deflate, sdch' -H 'Accept-Language: en-US,en;q=0.8' -H 'User-Agent: Mozilla/5.0 (X11; Linux x86_64) AppleWebKit/537.36 (KHTML, like Gecko) Ubuntu Chromium/41.0.2272.76 Chrome/41.0.2272.76 Safari/537.36' -H 'Content-Type: text/plain' -H 'Accept: text/plain, */*; q=0.01' --compressed
