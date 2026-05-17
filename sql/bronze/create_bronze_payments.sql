CREATE TABLE IF NOT EXISTS bronze.payments (
    order_id VARCHAR,
    payment_sequential INT,
    payment_type VARCHAR,
    payment_installments INT,
    payment_value DECIMAL(10, 2),

    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    source_file VARCHAR,
    batch_id VARCHAR
)