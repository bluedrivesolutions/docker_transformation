{{
	config(
		materialized='table'
        , schema='prod'
	) 
}}

WITH numbers AS (
  SELECT number
  FROM system.numbers
  LIMIT dateDiff('day', toDate('2020-01-01'), today()) + 1
),
date_spine AS (
  SELECT toDate('2020-01-01') + number AS date_day
  FROM numbers
),
date_dimension AS (
  SELECT
    toUInt32(date_day) AS date_key,
    date_day AS full_date,
    toYear(date_day) AS year,
    toMonth(date_day) AS month,
    toDayOfMonth(date_day) AS day,
    toDayOfWeek(date_day) AS day_of_week,
    toDayOfYear(date_day) AS day_of_year,
    toQuarter(date_day) AS quarter,
    (toDayOfWeek(date_day) IN (6, 7)) AS is_weekend
    -- formatDateTime(date_day, '%A') AS day_name,
    -- formatDateTime(date_day, '%B') AS month_name
  FROM date_spine
)
SELECT *
FROM date_dimension