-- ============================================================
-- Model: stg_customers
-- Description: Raw customers data ko clean karo
-- Layer: Staging
-- ============================================================

WITH raw_customers AS (
    SELECT * FROM {{ source('raw', 'customers') }}
)

SELECT
    id              AS customer_id,
    INITCAP(name)   AS customer_name,
    TRIM(city)      AS city,
    LOWER(email)    AS email
FROM raw_customers
WHERE id IS NOT NULL
