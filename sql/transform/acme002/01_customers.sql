TRUNCATE TABLE out_customers;
INSERT INTO out_customers (
	a__name, 
	a__state,
	cp__id )
SELECT 
	fullname,
	state,
	TO_NUMBER(customer_id)
FROM stg_csv_customers_merge;
