{{ config(materialized='table',
schema='silver') }}


SELECT
    order_id,
    SUM(payment_value) AS total_payments,
    MAX(payment_type) AS payment_type,
    SUM(payment_installments) AS total_installments

FROM bronze.payments
GROUP BY order_id