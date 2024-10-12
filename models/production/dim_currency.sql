{{
	config(
		materialized='view'
	) 
}}

WITH source AS (
      SELECT
            *
      FROM 
            {{ ref('stg_altpay_currency') }}
)
SELECT
      *
FROM 
      source
ORDER BY 
      currency_id