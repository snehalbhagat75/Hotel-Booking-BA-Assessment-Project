
## 32. SQL Q2 — Customer Repeat-Booking Gap Analysis


WITH completed_bookings AS
(
    SELECT
        customer_id,
        checkin_date,

        LAG(checkin_date) OVER
        (
            PARTITION BY customer_id
            ORDER BY checkin_date
        ) AS previous_checkin_date

    FROM `hotel_bookings (2)`

    WHERE booking_status = 'Completed'
),

booking_gaps AS
(
    SELECT
        customer_id,
        checkin_date,
        previous_checkin_date,

        DATEDIFF(
            checkin_date,
            previous_checkin_date
        ) AS gap_days

    FROM completed_bookings

    WHERE previous_checkin_date IS NOT NULL
),

customer_average_gap AS
(
    SELECT
        customer_id,
        AVG(gap_days) AS average_gap_days

    FROM booking_gaps

    GROUP BY customer_id
)

SELECT
    COUNT(*) AS customers_average_gap_under_30_days

FROM customer_average_gap

WHERE average_gap_days < 30;