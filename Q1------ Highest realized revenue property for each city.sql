
-- A-Q1
-- Highest realized revenue property for each city

WITH property_revenue AS (
    SELECT
        property_city,
        property_id,
        property_name,
        SUM(total_amount) AS revenue
    FROM `hotel_bookings (2)`
    WHERE checkout_date <= CURRENT_DATE
    GROUP BY
        property_city,
        property_id,
        property_name
),

ranked_properties AS (
    SELECT
        property_city,
        property_id,
        property_name,
        revenue,
        RANK() OVER (
            PARTITION BY property_city
            ORDER BY revenue DESC
        ) AS revenue_rank
    FROM property_revenue
)

SELECT
    property_city,
    property_id,
    property_name,
    revenue
FROM ranked_properties
WHERE revenue_rank = 1
ORDER BY property_city;