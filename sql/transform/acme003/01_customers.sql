TRUNCATE TABLE out_customers;
INSERT INTO out_customers (
	a__age,
	a__gender,
	a__state,
	a__postal_code,
	a__country_code,
	cp__id )
SELECT 
	AGE_IN_YEARS(TO_DATE(birthdate, 'YYYY-MM-DD')),
	gender,
	state,
	postal_code,
	country_code2,
	TO_NUMBER(customer_id)
FROM stg_csv_customers_merge;
