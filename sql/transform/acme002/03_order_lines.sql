TRUNCATE TABLE out_orderlines;
INSERT INTO out_orderlines (
	cp__orderlineid,
	f__price,
	f__quantity,
	r__orders,
	r__products 
	)
SELECT 
	order_line_id,
	TO_NUMBER(price),
	TO_NUMBER(quantity),
	order_id,
	product_id
FROM stg_csv_orders_merge
WHERE order_id IN (SELECT cp__order_id FROM out_orders)
ORDER BY 1