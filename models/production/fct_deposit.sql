{{
	config(
		materialized='table',
            tags=['stream']
	) 
}}

WITH source AS (
      SELECT
            deposit_id
            , commission
            , created
      FROM 
            {{ ref('stg_altpay_deposit') }}
)
SELECT
      *
FROM 
      source