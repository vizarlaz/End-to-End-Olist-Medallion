DROP TABLE IF EXISTS silver.orders_clean;

CREATE TABLE silver.orders_clean AS

SELECT DISTINCT
    order_id,
    customer_id,
    order_status,

    order_purchase_timestamp,
    order_approved_at,
    order_delivered_customer_date,
    order_estimated_delivery_date
FROM bronze.orders
WHERE order_id IS NOT NULL
AND customer_id IS NOT NULL
AND order_status != 'unavailable';