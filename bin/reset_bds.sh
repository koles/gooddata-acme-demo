# Reset the BDS before the demo

./bin/lib/dir_check.sh

s3_location="s3://gooddata-demo/acme/bds"

aws s3 rm --recursive ${s3_location}

aws s3 cp configuration/configuration.json ${s3_location}/configuration.json
aws s3 cp sql/transform/* ${s3_location}/transform/
