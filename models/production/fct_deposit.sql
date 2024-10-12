{{
	config(
		materialized='table'
	) 
}}

WITH source AS (
      SELECT
            *
      FROM 
            {{ ref('stg_altpay_deposit') }}
)
SELECT
      *
FROM 
      source