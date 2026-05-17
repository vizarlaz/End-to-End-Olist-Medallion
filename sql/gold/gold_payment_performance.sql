DROP TABLE IF EXISTS gold.payment_performance;

CREATE TABLE gold.payment_performance AS 

SELECT
    payment_type,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(SUM(total_payments)::numeric, 2) AS total_payment_value,
    ROUND(AVG(total_payments)::numeric, 2) AS average_payment

FROM silver.sales_clean

GROUP BY payment_type

ORDER BY total_payment_value DESC;