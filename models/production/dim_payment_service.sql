{{
	config(
		materialized='table'
	) 
}}

WITH source AS (
      SELECT
            *
      FROM 
            {{ ref('stg_altpay_payment_service') }}
)
SELECT
      *
FROM 
      source