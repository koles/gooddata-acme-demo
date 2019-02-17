./bin/lib/dir_check.sh

if [ ! -d ~/.aws ]; then
  echo "AWS Command Line Interface not installed or configured."
  echo " Try: $ aws configure"
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
s3_location="s3://gooddata-demo/acme"
pathname="${s3_location}/source/data"
./bin/add2manifest.sh -p $pathname $orders_file
manifest="manifest_*.csv"
./bin/add2manifest.sh -p $pathname $customers_file $manifest


# upload files to S3
aws s3 rm --recursive ${s3_location}/source/
aws s3 cp configuration/feed.txt ${s3_location}/source/configuration/feed.txt
aws s3 cp $orders_file s${s3_location}/source/data/
aws s3 cp $customers_file ${s3_location}/source/data/
aws s3 cp $manifest ${s3_location}/source/manifest/

# move files somewhere else
mv $customers_file $orders_file $manifest data/processed
echo "Files moved to data/processed folder"
