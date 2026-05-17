SELECT
    MIN(total_order_value) AS min_revenue,
    MAX(total_order_value) AS max_revenue,
    AVG(total_order_value) AS avg_revenue
FROM silver.sales_clean;
