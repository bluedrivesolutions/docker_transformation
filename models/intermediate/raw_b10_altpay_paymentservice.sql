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
            {{ source('airbyte_internal', 'raw_raw__stream_b10_altpay_paymentservice') }}
)
SELECT
      -- Airbyte metadata
      _airbyte_raw_id
      , _airbyte_data
      , _airbyte_extracted_at
      , _airbyte_loaded_at

      -- Extract fields from _airbyte_data
      , JSONExtractString(_airbyte_data, 'id') as ps_id
      , JSONExtractString(_airbyte_data, 'service_code') as ps_service_code
      , JSONExtractString(_airbyte_data, 'active') as ps_active
      , JSONExtractString(_airbyte_data, 'created') as ps_created
      , JSONExtractString(_airbyte_data, 'updated') as ps_updated
      , JSONExtractString(_airbyte_data, 'logo_url') as ps_logo_url
FROM 
      source