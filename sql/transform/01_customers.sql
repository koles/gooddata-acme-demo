TRUNCATE TABLE out_customers;
INSERT INTO out_customers (
	cp__id,
	a__name,
	a__age,
	a__gender,
	a__state,
	a__postal_code,
	a__country_code
 )
SELECT
	TO_NUMBER(customer_id),
	fullname,
	AGE_IN_YEARS(TO_DATE(birthdate, 'YYYY-MM-DD')),
	gender,
	state,
	postal_code,
	country_code2
FROM stg_csv_customers_merge;
