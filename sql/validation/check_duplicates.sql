SELECT
    order_id,
    product_id,
    COUNT(*)
FROM silver.sales_clean
GROUP BY
    order_id,
    product_id
HAVING COUNT(*) > 1;