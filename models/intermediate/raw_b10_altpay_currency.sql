-- The raw model represents the data as it comes directly from the source, with minimal to no transformations.
-- Get the airbyte data.
-- Flatten the data already.

{{
	config(
		materialized='table'
	) 
}}

WITH source AS (
      SELECT
            _airbyte_raw_id,
            _airbyte_data,
            _airbyte_extracted_at,
            _airbyte_loaded_at
      FROM 
            {{ source('airbyte_internal', 'raw_raw__stream_b10_altpay_currency') }}
)
SELECT
      -- Airbyte metadata
      _airbyte_raw_id
      , _airbyte_data
      , _airbyte_extracted_at
      , _airbyte_loaded_at

      -- Extract fields from _airbyte_data
      , JSONExtractString(_airbyte_data, 'id') as currency_id
      , JSONExtractString(_airbyte_data, 'name') as currency_name
      , JSONExtractString(_airbyte_data, 'code') as currency_code
      , JSONExtractString(_airbyte_data, 'symbol') as currency_symbol
      , JSONExtractString(_airbyte_data, 'decimals') as currency_decimal
FROM 
      source