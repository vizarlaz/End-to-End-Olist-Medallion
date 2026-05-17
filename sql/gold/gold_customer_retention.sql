DROP TABLE IF EXISTS gold.customer_retention;

CREATE TABLE gold.customer_retention AS

WITH customer_orders AS (

    SELECT DISTINCT
        customer_id,
        DATE_TRUNC('month', order_purchase_timestamp)::date AS order_month
    FROM silver.sales_clean
    WHERE customer_id IS NOT NULL

),

retention AS (

    SELECT
        a.order_month,
        COUNT(DISTINCT a.customer_id) AS active_customers,
        COUNT(DISTINCT b.customer_id) AS retained_customers

    FROM customer_orders a

    LEFT JOIN customer_orders b
        ON a.customer_id = b.customer_id
        AND b.order_month = (
            a.order_month + INTERVAL '1 month'
        )::date

    GROUP BY a.order_month

)

SELECT
    order_month,
    active_customers,
    retained_customers,

    ROUND(
        retained_customers * 100.0 /
        NULLIF(active_customers, 0),
        2
    ) AS retention_rate

FROM retention
ORDER BY order_month;