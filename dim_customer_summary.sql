-- ============================================================
-- Model: dim_customer_summary
-- Description: Customer level summary — total orders, revenue
-- Layer: Marts
-- ============================================================

WITH orders AS (
    SELECT * FROM {{ ref('fct_orders') }}
),

summary AS (
    SELECT
        customer_id,
        customer_name,
        city,
        COUNT(order_id)                             AS total_orders,
        SUM(revenue)                                AS total_revenue,
        AVG(amount)                                 AS avg_order_value,
        MIN(order_date)                             AS first_order_date,
        MAX(order_date)                             AS last_order_date,
        COUNT(CASE WHEN status = 'completed'
              THEN 1 END)                           AS completed_orders,
        COUNT(CASE WHEN status = 'cancelled'
              THEN 1 END)                           AS cancelled_orders,

        -- Customer segment
        CASE
            WHEN SUM(revenue) >= 100000 THEN 'Premium'
            WHEN SUM(revenue) >= 50000  THEN 'Regular'
            ELSE 'New'
        END AS customer_segment

    FROM orders
    GROUP BY customer_id, customer_name, city
)

SELECT * FROM summary
