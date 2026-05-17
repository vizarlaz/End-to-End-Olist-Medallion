SELECT COUNT(*)
FROM silver.orders_clean
WHERE customer_id NOT IN (
    SELECT customer_id 
    FROM silver.customers_clean
);