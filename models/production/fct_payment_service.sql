-- The production model applies business logic, 
-- creates calculated fields, and structures the data for analytical use.
-- lessen the datas not needed

{{
	config(
		materialized='table'
	) 
}}

WITH source AS (
      SELECT
            *
      FROM 
            {{ ref('stg_bahigo_altpay_deposit') }}
)
SELECT
      *
FROM 
      source