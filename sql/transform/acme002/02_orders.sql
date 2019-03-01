TRUNCATE TABLE out_orders;
INSERT INTO out_orders (
	cp__order_id,
	d__date,
	a__orderstatus,
	a__ordertype,
	r__customers,
	r__campaigns,
	f__shippingamount
)
SELECT DISTINCT
	order_id, 
	TO_DATE(order_date, 'YYYY-MM_DD') AS order_date,
	order_status,
	order_type, 
	TO_NUMBER(customer_id), 
	campaign_id,
	TO_NUMBER(shipping_amount)
FROM stg_csv_orders_merge O 
LEFT OUTER JOIN stg_csv_campaign_channels_merge C
ON O.tracking_code = C.tracking_code
WHERE TO_DATE(order_date, 'YYYY-MM_DD') < CURRENT_DATE
ORDER BY order_id;