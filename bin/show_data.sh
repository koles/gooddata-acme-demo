# Just showing the structure of the data files
# Uses csvkit

./bin/lib/dir_check.sh

clear;
echo "Customers"
head -n 10 data/customers.csv | csvcut -C 4,5,7,8 | csvlook

echo ""
echo "Orders"
head -n 10 data/orders.csv | csvlook
