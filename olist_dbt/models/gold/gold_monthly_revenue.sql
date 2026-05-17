SELECT

    DATE_TRUNC(
        'month',
        order_purchase_timestamp::date
    ) AS month,
    ROUND(
        SUM(total_order_value)::numeric,
        2
    ) AS revenue,
    COUNT(DISTINCT order_id) AS total_orders,
    COUNT(DISTINCT customer_id) AS unique_customers

FROM {{ ref('silver_sales_clean') }}

GROUP BY month
ORDER BY month