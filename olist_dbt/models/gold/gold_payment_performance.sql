SELECT
    payment_type,
    COUNT(DISTINCT order_id) AS total_orders,
    ROUND(
        SUM(total_payments)::numeric,
        2
    ) AS total_payment_value,
    ROUND(
        AVG(total_payments)::numeric,
        2
    ) AS average_payment
FROM
    {{ ref('silver_sales_clean') }}

GROUP BY payment_type
ORDER BY total_payment_value DESC