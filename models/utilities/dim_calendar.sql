{{
      config(
            materialized='view',
            schema='prod'
      )
}}

-- configuration
{% set start_year = var('start_year', 2020) %}

-- selection
WITH date_spine AS (
      SELECT
            toDate('{{ start_year }}-01-01') + number AS date_day
      FROM 
            system.numbers
      LIMIT 
            dateDiff('day', toDate('{{ start_year }}-01-01'), 
            toDate(concat(toString(toYear(today())), '-12-31'))) + 1
),
date_dimension AS (
      SELECT
            date_day AS full_date,
            toYear(date_day) AS year,
            toMonth(date_day) AS month,
            formatDateTime(date_day, '%b') AS month_name,
            toDayOfMonth(date_day) AS day,
            toDayOfWeek(date_day) AS day_of_week,
            formatDateTime(date_day, '%a') AS day_name,
            toDayOfYear(date_day) AS day_of_year,
            toQuarter(date_day) AS quarter,
            if(toDayOfWeek(date_day) IN (6, 7), true, false) AS is_weekend
      FROM date_spine
)

SELECT 
      *
FROM 
      date_dimension
ORDER BY 
      full_date DESC