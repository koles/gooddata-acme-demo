TRUNCATE TABLE out_products;
INSERT INTO out_products (cp__product_id, a__product_name, a__category)
SELECT product_id, product_name, category 
FROM stg_csv_categories_products_merge;