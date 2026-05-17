DROP TABLE IF EXISTS silver.customers_clean;

CREATE TABLE silver.customers_clean AS

SELECT DISTINCT
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    INITCAP(customer_city) AS customer_city,
    UPPER(customer_state) AS customer_state

FROM bronze.customers

WHERE customer_id IS NOT NULL;