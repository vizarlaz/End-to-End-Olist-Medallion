DROP TABLE IF EXISTS gold.monthly_revenue;

CREATE TABLE gold.monthly_revenue AS 

SELECT
    DATE_TRUNC('month', order_purchase_timestamp) AS month,
    ROUND(SUM(total_order_value)::numeric, 2) AS revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers

FROM silver.sales_clean

GROUP BY month

ORDER BY month;