{{ config(
    engine='MergeTree()',
    order_by='date_key',
    partition_by='toYear(date_key)',
    schema='prod'
) }}

WITH date_spine AS (
    {{ dbt_utils.date_spine(
        datepart="day",
        start_date="toDate('2010-01-01')",
        end_date="toDate('2024-12-31')"
    ) }}
)

SELECT
    toDate(date_day) AS date_key,
    toYear(date_key) AS year,
    toQuarter(date_key) AS quarter,
    toMonth(date_key) AS month,
    toDayOfMonth(date_key) AS day_of_month,
    toDayOfWeek(date_key) AS day_of_week,
    toMonday(date_key) AS week_start_date,
    toISOWeek(date_key) AS iso_week,
--     formatDateTime(date_key, '%b') AS month_name_short,
--     formatDateTime(date_key, '%B') AS month_name_full,
    formatDateTime(date_key, '%a') AS day_name_short,
    formatDateTime(date_key, '%W') AS day_name_full,
    CASE
        WHEN toMonth(date_key) < 2 THEN toYear(date_key)
        ELSE toYear(date_key) + 1
    END AS fiscal_year,
    CASE
        WHEN toMonth(date_key) < 2 THEN 4
        WHEN toMonth(date_key) < 5 THEN 1
        WHEN toMonth(date_key) < 8 THEN 2
        WHEN toMonth(date_key) < 11 THEN 3
        ELSE 4
    END AS fiscal_quarter
FROM date_spine