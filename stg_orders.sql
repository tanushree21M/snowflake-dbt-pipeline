-- ============================================================
-- Model: stg_orders
-- Description: Raw orders data ko clean karo
-- Layer: Staging (raw se clean)
-- ============================================================

WITH raw_orders AS (
    SELECT * FROM {{ source('raw', 'orders') }}
),

cleaned AS (
    SELECT
        order_id,
        customer_id,
        UPPER(TRIM(product))            AS product,
        COALESCE(amount, 0)             AS amount,
        order_date::DATE                AS order_date,
        LOWER(TRIM(status))             AS status,
        DATE_TRUNC('month', order_date) AS order_month
    FROM raw_orders
    WHERE order_id IS NOT NULL
)

SELECT * FROM cleaned
