CREATE TABLE "out_orders" (
    "a__customer_first_order_age" INTEGER,
    "a__customer_gender" VARCHAR(8),
    "a__product_category" VARCHAR(160),
    "d__orderdate" DATE,
    "f__price" NUMERIC(12,2),
    "f__quantity" NUMERIC(12,2)

-- Uncomment only if you really know the consequences of your decision
-- ,    "x__client_id" VARCHAR(128) ENCODING RLE
-- ,    "x__timestamp" TIMESTAMP ENCODING RLE
-- ,    "x__deleted" BOOLEAN DEFAULT false ENCODING RLE
);
