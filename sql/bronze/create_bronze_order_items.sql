CREATE TABLE IF NOT EXISTS bronze.order_items (
    order_id VARCHAR,
    order_item_id INT,
    product_id VARCHAR,
    seller_id VARCHAR,
    shipping_limit_date TIMESTAMP,
    price NUMERIC,
    freight_value NUMERIC,

    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    source_file VARCHAR,
    batch_id VARCHAR
);