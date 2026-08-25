q1_sql = """-- A-Q1
WITH property_revenue AS (
    SELECT
        p.property_city,
        p.property_id,
        p.property_name,
        SUM(
            CASE
                WHEN b.booking_status = 'Completed'
                THEN b.total_amount
                ELSE 0
            END
        ) AS realized_revenue
    FROM properties p
    JOIN bookings b
        ON b.property_id = p.property_id
    GROUP BY
        p.property_city,
        p.property_id,
        p.property_name
),
ranked AS (
    SELECT
        *,
        RANK() OVER (
            PARTITION BY property_city
            ORDER BY realized_revenue DESC
        ) AS revenue_rank
    FROM property_revenue
)
SELECT
    property_city,
    property_id,
    property_name,
    realized_revenue
FROM ranked
WHERE revenue_rank = 1
ORDER BY property_city;
"""
