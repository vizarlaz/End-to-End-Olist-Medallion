CREATE TABLE IF NOT EXISTS bronze.orders (
    order_id VARCHAR,
    customer_id VARCHAR,
    order_status VARCHAR,
    order_purchase_timestamp TIMESTAMP,
    order_approved_at TIMESTAMP,
    order_delivered_carrier_date TIMESTAMP,
    order_delivered_customer_date TIMESTAMP,
    order_estimated_delivery_date TIMESTAMP,

    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    source_file VARCHAR,
    batch_id VARCHAR
);
