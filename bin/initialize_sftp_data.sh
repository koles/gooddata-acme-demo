./bin/lib/dir_check.sh

if [ ! -f ~/.sshpass_acme ]; then
  echo "error: .sshpass_acme file not found"
  exit 1
fi
set -e

# Prepare initial data files
echo "Copying initial data files..."
timestamp=`date "+%s"`
orders_file="data/temp/orders_1_${timestamp}.csv"
cp data/orders.csv $orders_file

customers_file="data/temp/customers_1_${timestamp}.csv"
cp data/customers.csv $customers_file

# create the manifest file
pathname="/stfp4demo"
./bin/add2manifest.sh -p $pathname $orders_file
manifest=`ls manifest_*.csv | tail -n 1`
./bin/add2manifest.sh -p $pathname $customers_file $manifest


# upload files to SFTP server -- read warnings on security on sshpass man page
export SSHUSER=stfp4demo
export SSHPASS=`cat ~/.sshpass_acme`
sshpass -v -e sftp -oBatchMode=no -b - ${SSHUSER}@financial-services-gd.com << !!
cd stfp4demo
put ${orders_file}
put ${customers_file}
put configuration/feed.txt
-mkdir manifest
cd manifest
put ${manifest}
bye
!!

# move files somewhere else
mv $customers_file $orders_file $manifest data/processed
echo "Files moved to data/processed folder"
