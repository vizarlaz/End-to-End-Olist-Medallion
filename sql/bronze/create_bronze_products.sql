CREATE TABLE IF NOT EXISTS bronze.products (
product_id VARCHAR,
product_category_name VARCHAR,
product_name_lenght INT,
product_description_lenght INT ,
product_photos_qty INT,
product_weight_g INT,
product_length_cm DECIMAL(10, 2),
product_height_cm DECIMAL(10, 2),
product_width_cm DECIMAL (10, 2),

ingestion_time TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
source_file VARCHAR,
batch_id VARCHAR


)

