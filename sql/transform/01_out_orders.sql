truncate table out_orders;
insert into out_orders (
		a__customer_first_order_age, a__customer_gender,
		a__product_category, d__orderdate, f__price, f__quantity)
select
	age_in_years(order_date, birthdate) as order_age,
	gender,
	category,
	order_date,
	price,
	quantity
from stg_csv_customers_merge c, stg_csv_orders_merge o
where o.customer_id = c.customer_id
  and c.birthdate is not null;
