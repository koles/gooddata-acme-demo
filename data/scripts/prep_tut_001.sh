if [ ! -d scripts/ ]; then
	echo "Please run this command in the GoodData project/data directory."
	exit 1
fi

DATA_DIR=./source
TEMP_DIR=./temp
ORDERS=`ls $DATA_DIR/orders_1_* | tail -1`

csvjoin -c customer_id $ORDERS $DATA_DIR/customers.csv > $TEMP_DIR/temp1.csv
csvjoin -c product_id $TEMP_DIR/temp1.csv $DATA_DIR/categories_products.csv > $TEMP_DIR/temp2.csv
csvcut -c order_line_id,order_id,order_date,order_status,customer_id,fullname,state,product_id,product_name,category,price,quantity,tracking_code $TEMP_DIR/temp2.csv > $TEMP_DIR/temp3.csv
csvjoin --left -c tracking_code $TEMP_DIR/temp3.csv $DATA_DIR/campaign_channels.csv > $TEMP_DIR/temp4.csv
csvcut -c 1-12,14,17,18 $TEMP_DIR/temp4.csv > $DATA_DIR/orders_tut_001.csv
rm $TEMP_DIR/temp[1-4].csv
