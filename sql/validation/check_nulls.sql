SELECT
    SUM(CASE WHEN customer_id IS NULL THEN 1 ELSE 0 END)
        AS null_customer_id,

    SUM(CASE WHEN order_id IS NULL THEN 1 ELSE 0 END)
        AS null_order_id,

    SUM(CASE WHEN total_order_value IS NULL THEN 1 ELSE 0 END)
        AS null_total_order_value

FROM silver.sales_clean;