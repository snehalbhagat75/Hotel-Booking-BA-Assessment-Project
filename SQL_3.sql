
q2_sql = """-- A-Q2
-- MySQL version using DATEDIFF.
WITH completed_bookings AS (
    SELECT
        customer_id,
        checkin_date,
        LAG(checkin_date) OVER (
            PARTITION BY customer_id
            ORDER BY checkin_date
        ) AS previous_checkin_date
    FROM bookings
    WHERE booking_status = 'Completed'
),
gaps AS (
    SELECT
        customer_id,
        DATEDIFF(checkin_date, previous_checkin_date) AS gap_days
    FROM completed_bookings
    WHERE previous_checkin_date IS NOT NULL
),
customer_avg_gap AS (
    SELECT
        customer_id,
        AVG(gap_days) AS average_gap_days
    FROM gaps
    GROUP BY customer_id
)
SELECT COUNT(*) AS customers_average_gap_under_30_days
FROM customer_avg_gap
WHERE average_gap_days < 30;
"""