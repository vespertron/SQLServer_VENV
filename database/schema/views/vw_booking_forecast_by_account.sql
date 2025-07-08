CREATE OR ALTER VIEW fin.vw_booking_forecast_by_account AS
SELECT 
    coa.account_id,
    coa.account_code,
    coa.account_name,
    coa.account_type,
    SUM(b.amount) AS total_forecasted_amount,
    COUNT(b.booking_id) AS booking_count,
    MIN(b.booking_date) AS earliest_booking,
    MAX(b.booking_date) AS latest_booking
FROM fin.bookings b
JOIN fin.chart_of_accounts coa ON b.account_id = coa.account_id
WHERE b.status IN ('Booked', 'Confirmed') -- Only include unfulfilled bookings
GROUP BY 
    coa.account_id,
    coa.account_code,
    coa.account_name,
    coa.account_type;