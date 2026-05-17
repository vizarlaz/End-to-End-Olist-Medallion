WITH customer_orders AS (
    SELECT
        customer_id,
        DATE_TRUNC('month', order_purchase_timestamp::date) AS order_month
    FROM {{ ref('silver_sales_clean') }}
    ),

monthly_customers AS (
    SELECT DISTINCT
        customer_id,
        order_month
    FROM customer_orders
),

retention AS (
    SELECT
        a.order_month,
        COUNT(DISTINCT a.customer_id) AS active_customers,
        COUNT(DISTINCT b.customer_id) AS retained_customers
FROM monthly_customers a
LEFT JOIN monthly_customers b
    ON a.customer_id = b.customer_id
    AND b.order_month = a.order_month + INTERVAL '1 month'
GROUP BY a.order_month
)

SELECT
    order_month,
    active_customers,
    retained_customers,
    ROUND((retained_customers::numeric / NULLIF(active_customers, 0))* 100, 2) AS retention_rate
FROM retention
ORDER BY order_month