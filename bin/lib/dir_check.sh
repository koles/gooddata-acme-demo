if [ ! -d data/ ]; then
	echo "Please run this command in the GoodData project directory."
	exit 1
fi
if [ ! -d data/temp ]; then
  echo "creating data/temp directory"
  mkdir data/temp
fi
if [ ! -d data/processed ]; then
  echo "creating data/processed directory"
  mkdir data/processed
fi

for file in \
  configuration/configuration.json \
  configuration/feed.txt \
  data/customers.csv \
  data/orders.csv
do
    if [ ! -f $file ]; then
      echo "file: $file is missing"
      exit 1;
    fi
done
