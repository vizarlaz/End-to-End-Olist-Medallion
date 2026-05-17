DROP TABLE IF EXISTS gold.daily_sales;

CREATE TABLE gold.daily_sales AS

SELECT
    DATE(order_purchase_timestamp) AS sales_date,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers,
    ROUND(SUM(total_order_value)::numeric, 2) AS revenue,
    ROUND(SUM(total_order_value)::numeric, 2) AS average_order_value

FROM silver.sales_clean

GROUP BY sales_date

ORDER BY sales_date;