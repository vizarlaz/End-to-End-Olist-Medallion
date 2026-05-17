DROP TABLE IF EXISTS gold.customer_lifetime_value;

CREATE TABLE gold.customer_lifetime_value AS 

SELECT
    customer_id,

    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(total_order_value)::numeric, 2) AS lifetime_value,
    ROUND(AVG(total_order_value)::numeric, 2) AS avg_order_value,
    MIN(order_purchase_timestamp) AS first_purchase,
    MAX(order_purchase_timestamp) AS last_purchase

FROM silver.sales_clean
GROUP BY customer_id
ORDER BY lifetime_value DESC;