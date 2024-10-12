{{
	config(
		materialized='table',
            tags=['streaming']
	) 
}}

WITH source AS (
      SELECT
            *
      FROM 
            {{ ref('stg_altpay_payout') }}
)
SELECT
      *
FROM 
      source