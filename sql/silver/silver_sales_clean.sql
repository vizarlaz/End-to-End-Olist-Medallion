DROP TABLE IF EXISTS silver.sales_clean;

CREATE TABLE silver.sales_clean AS

WITH payment_summary AS (
    SELECT
        order_id,
        SUM(payment_value) AS total_payments,
        MAX(payment_type) AS payment_type
    FROM bronze.payments
    GROUP BY order_id
)

SELECT
    o.order_id,
    c.customer_id,
    oi.product_id,
    p.product_category_name,
    o.order_status,
    o.order_purchase_timestamp,
    oi.price,
    oi.freight_value,
    ps.total_payments,
    ps.payment_type,
    (COALESCE(oi.price, 0) + COALESCE(oi.freight_value, 0)) AS total_order_value

FROM bronze.orders o

LEFT JOIN bronze.customers c
    ON o.customer_id = c.customer_id

LEFT JOIN bronze.order_items oi
    ON o.order_id = oi.order_id

LEFT JOIN bronze.products p
    ON oi.product_id = p.product_id

LEFT JOIN payment_summary ps
    ON o.order_id = ps.order_id;