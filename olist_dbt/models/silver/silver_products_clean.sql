{{ config(materialized='table',
schema='silver') }}


SELECT DISTINCT
    product_id,

    COALESCE(
        product_category_name,
        'unknown'
    ) AS product_category_name,
    product_weight_g,
    product_length_cm,
    product_height_cm,
    product_width_cm
FROM bronze.products
WHERE product_id IS NOT NULL