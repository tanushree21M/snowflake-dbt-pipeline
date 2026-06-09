-- ============================================================
-- Model: fct_orders
-- Description: Final orders fact table — analytics ke liye
-- Layer: Marts (business ready)
-- ============================================================

WITH orders AS (
    SELECT * FROM {{ ref('stg_orders') }}
),

customers AS (
    SELECT * FROM {{ ref('stg_customers') }}
),

final AS (
    SELECT
        o.order_id,
        o.customer_id,
        c.customer_name,
        c.city,
        o.product,
        o.amount,
        o.order_date,
        o.order_month,
        o.status,

        -- Revenue sirf completed orders ke liye
        CASE
            WHEN o.status = 'completed' THEN o.amount
            ELSE 0
        END AS revenue,

        -- Amount category
        CASE
            WHEN o.amount >= 50000 THEN 'High'
            WHEN o.amount >= 10000 THEN 'Medium'
            ELSE 'Low'
        END AS amount_category,

        -- Loaded timestamp
        CURRENT_TIMESTAMP AS loaded_at

    FROM orders o
    LEFT JOIN customers c ON o.customer_id = c.customer_id
)

SELECT * FROM final
