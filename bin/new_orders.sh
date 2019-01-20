# Download new orders, create manifest, upload to SFTP

./bin/lib/dir_check.sh
if [ ! -f ~/.sshpass_acme ]; then
  echo "error: .sshpass_acme file not found"
  exit 1
fi
set -e

# Get new sample data rows
timestamp=`date "+%s"`
orders_file="data/temp/orders_1_${timestamp}.csv"
curl "https://api.mockaroo.com/api/39ba8c90?count=500&key=66099da0" > $orders_file

# create the manifest file and upload it to S3
pathname="/stfp4demo"
./bin/add2manifest.sh -p $pathname $orders_file
manifest=`ls manifest_*.csv | tail -n 1`

# upload files to SFTP server -- read warnings on security on sshpass man page
export SSHUSER=stfp4demo
export SSHPASS=`cat ~/.sshpass_acme`
sshpass -v -e sftp -oBatchMode=no -b - ${SSHUSER}@financial-services-gd.com << !!
   cd stfp4demo
   put ${orders_file}
	 cd manifest
	 put ${manifest}
	 bye
!!

# move files somewhere else
mv $orders_file data/processed
mv $manifest data/processed
