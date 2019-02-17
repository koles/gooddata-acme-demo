# Create manifest and upload a data file
# Be sure the feed.txt file has been updated if there is a new entity

./bin/lib/dir_check.sh

if [ ! -d ~/.aws ]; then
  echo "AWS Command Line Interface not installed or configured."
  echo " Try: $ aws configure"
  exit 1
fi

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
s3_location="s3://gooddata-demo/acme"
pathname="${s3_location}/source/data"
./bin/add2manifest.sh -p $pathname $newfile
manifest=`ls manifest_*.csv | tail -n 1`

# upload files to S3
aws s3 cp configuration/feed.txt ${s3_location}/source/configuration/feed.txt
aws s3 cp $newfile ${s3_location}/source/data/
aws s3 cp $manifest ${s3_location}/source/manifest/

# move files somewhere else
mv $newfile data/processed
mv $manifest data/processed
