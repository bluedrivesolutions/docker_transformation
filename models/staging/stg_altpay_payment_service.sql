{{
	config(
		materialized='table'
	) 
}}

-- models/staging/stg_deposits.sql
WITH source AS (
      SELECT
            *
      FROM 
            {{ ref('raw_bahigo_altpay_paymentservice') }}
      UNION ALL
      SELECT
            *
      FROM 
            {{ ref('raw_b10_altpay_paymentservice') }}
)
SELECT 
      ps_id
      , ps_service_code
      , ps_active
      , ps_created
      , ps_updated

      -- , ps_logo_url

      -- , _airbyte_raw_id
      -- , _airbyte_data
      -- , _airbyte_extracted_at
      -- , _airbyte_loaded_at
FROM 
      source
WHERE 
      ps_id IS NOT NULL