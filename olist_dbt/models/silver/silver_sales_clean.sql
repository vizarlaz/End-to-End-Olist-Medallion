{{ config(materialized='table',
schema='silver') }}

SELECT

    oi.order_id,
    o.customer_id,
    oi.product_id,
    p.product_category_name,
    o.order_status,
    o.order_purchase_timestamp,
    oi.price,
    oi.freight_value,
    pay.total_payments,
    pay.payment_type,

    (
        COALESCE(oi.price, 0)
        +
        COALESCE(oi.freight_value, 0)

    ) AS total_order_value

FROM bronze.order_items oi

LEFT JOIN {{ ref('silver_orders_clean') }} o
    ON oi.order_id = o.order_id

LEFT JOIN {{ ref('silver_products_clean') }} p
    ON oi.product_id = p.product_id

LEFT JOIN {{ ref('silver_payments_clean') }} pay
    ON oi.order_id = pay.order_id

WHERE o.customer_id IS NOT NULL