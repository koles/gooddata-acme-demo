# Create manifest and upload a data file
# Be sure the feed.txt file has been updated if there is a new entity

./bin/lib/dir_check.sh

if [ ! -f ~/.sshpass_acme ]; then
  echo "error: .sshpass_acme file not found"
  exit 1
fi
set -e

# set the data file location
if [ ! -f ${1} ]; then
	echo "No data file found called ${1}"
	exit 1
else
	datafile=$1
fi

# construct timestamped data file name
# datafile name should start with entity name, i.e. entity_2015_2019.csv
timestamp=`date "+%s"`
entity=`basename ${datafile%%_*}`
newfile="data/temp/${entity}_1_${timestamp}.csv"
cp $datafile $newfile

# create the manifest file
pathname="/stfp4demo"
./bin/add2manifest.sh -p $pathname $newfile
manifest=`ls manifest_*.csv | tail -n 1`

# upload files to SFTP server -- read warnings on security on sshpass man page
export SSHUSER=stfp4demo
export SSHPASS=`cat ~/.sshpass_acme`
sshpass -v -e sftp -oBatchMode=no -b - ${SSHUSER}@financial-services-gd.com << !!
cd ${pathname}
put ${newfile}
put configuration/feed.txt
-mkdir manifest
cd manifest
put ${manifest}
bye
!!

# move files somewhere else
mv $newfile data/processed
mv $manifest data/processed
