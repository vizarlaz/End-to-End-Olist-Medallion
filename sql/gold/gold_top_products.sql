DROP TABLE IF EXISTS gold.top_products;

CREATE TABLE gold.top_products AS 

SELECT 
    product_id,
    product_category_name,
    COUNT(order_id) AS total_orders,
    ROUND(SUM(total_order_value)::numeric, 2) AS total_revenue,
    ROUND(AVG(total_order_value)::numeric, 2) AS avg_sales
FROM silver.sales_clean

GROUP BY
    product_id,
    product_category_name

ORDER BY total_revenue DESC;