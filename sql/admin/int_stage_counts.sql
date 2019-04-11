select 'orders' as entity,
	(select count(*) from src_csv_orders_merge) as 'input',
	(select count(*) from src_csv_orders_merge_uniq) as 'uniq',
	(select count(*) from src_csv_orders_merge_diff) as 'diff',
	(select count(*) from stg_csv_orders_merge) as 'merge',
	(select count(*) from out_orders) as 'output'
from dual
UNION
select 
	'customers' as entity,
	(select count(*) from src_csv_customers_merge) as 'input',
	(select count(*) from src_csv_customers_merge_uniq) as 'uniq',
	(select count(*) from src_csv_customers_merge_diff) as 'diff',
	(select count(*) from stg_csv_customers_merge) as 'merge',
	(select count(*) from out_customers) as 'output'
from dual
	