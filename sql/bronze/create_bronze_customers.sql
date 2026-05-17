
CREATE TABLE IF NOT EXISTS bronze.customers(
    customer_id VARCHAR,
    customer_unique_id VARCHAR,
    customer_zip_code_prefix VARCHAR,
    customer_city VARCHAR,
    customer_state VARCHAR,

    ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    source_file VARCHAR,
    batch_id VARCHAR
);