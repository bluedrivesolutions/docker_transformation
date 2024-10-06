-- The staging model performs initial cleaning and type casting. 
-- It extracts and formats the JSON data from the _airbyte_data column.
-- lessen the datas not needed

{{
	config(
		materialized='table'
	) 
}}

-- models/staging/stg_deposits.sql
WITH source AS (
      SELECT
            _airbyte_raw_id
            , _airbyte_data
            , _airbyte_extracted_at
            , _airbyte_loaded_at
            , currency_id
            , currency_name
            , currency_code
            , currency_symbol
            , currency_decimal
      FROM 
            {{ ref('raw_bahigo_altpay_currency') }}
)
SELECT 
      *
FROM 
      source