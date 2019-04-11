TRUNCATE TABLE out_orders;
INSERT INTO out_orders (
	cp__orderlineid,
	a__order_id,
	d__date,
	a__orderstatus,
	r__customers,
	r__campaigns,
	r__products,
	f__orderlines__price,
	f__orderlines__quantity
)
SELECT DISTINCT
	order_line_id,
	order_id, 
	TO_DATE(order_date, 'YYYY-MM_DD') AS order_date,
	order_status,
	TO_NUMBER(customer_id), 
	campaign_id,
	product_id,
	TO_NUMBER(price),
	TO_NUMBER(quantity)
FROM stg_csv_orders_merge O 
LEFT OUTER JOIN stg_csv_campaign_channels_merge C
ON O.tracking_code = C.tracking_code
WHERE TO_DATE(order_date, 'YYYY-MM_DD') <= CURRENT_DATE
ORDER BY order_line_id;