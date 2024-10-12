-- The production model applies business logic, 
-- creates calculated fields, and structures the data for analytical use.
-- lessen the datas not needed

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