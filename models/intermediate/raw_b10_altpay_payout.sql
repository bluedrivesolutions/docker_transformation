-- The raw model represents the data as it comes directly from the source, with minimal to no transformations.
-- Get the airbyte data.
-- Flatten the data already.

{{
	config(
		materialized='table',
            tags=['streaming']
	) 
}}

WITH source AS (
      SELECT
            _airbyte_raw_id,
            _airbyte_data,
            _airbyte_extracted_at,
            _airbyte_loaded_at
      FROM 
            {{ source('airbyte_internal', 'raw_raw__stream_b10_altpay_payout') }}
)
SELECT
      -- Airbyte metadata
      _airbyte_raw_id
      , _airbyte_data
      , _airbyte_extracted_at
      , _airbyte_loaded_at

      -- Extract fields from _airbyte_data
      , JSONExtractString(_airbyte_data, 'id') AS id
      , JSONExtractString(_airbyte_data, 'full_name') AS full_name
      , JSONExtractString(_airbyte_data, 'customer_email') AS customer_email
      , JSONExtractString(_airbyte_data, 'account') AS account
      , JSONExtractString(_airbyte_data, 'amount') AS amount
      , JSONExtractString(_airbyte_data, 'commission') AS commission
      , JSONExtractString(_airbyte_data, 'signature') AS signature
      , JSONExtractString(_airbyte_data, 'external_payout_id') AS external_payout_id
      , JSONExtractString(_airbyte_data, 'internal_payout_id') AS internal_payout_id
      , JSONExtractString(_airbyte_data, 'external_user_id') AS external_user_id
      , JSONExtractString(_airbyte_data, 'redirect_complete_url') AS redirect_complete_url
      , JSONExtractString(_airbyte_data, 'redirect_cancel_url') AS redirect_cancel_url
      , JSONExtractString(_airbyte_data, 'external_url') AS external_url
      , JSONExtractString(_airbyte_data, 'created') AS created
      , JSONExtractString(_airbyte_data, 'updated') AS updated
      , JSONExtractString(_airbyte_data, 'last_decision') AS last_decision
      , JSONExtractString(_airbyte_data, 'note') AS note
      , JSONExtractString(_airbyte_data, 'cancellation_reason') AS cancellation_reason
      , JSONExtractString(_airbyte_data, 'state') AS state
      , JSONExtractString(_airbyte_data, 'extra_data') AS extra_data
      , JSONExtractString(_airbyte_data, 'currency_id') AS currency_id
      , JSONExtractString(_airbyte_data, 'merchant_user_id') AS merchant_user_id
      , JSONExtractString(_airbyte_data, 'payout_type_id') AS payout_type_id
      , JSONExtractString(_airbyte_data, 'settlement_commission') AS settlement_commission
      , JSONExtractString(_airbyte_data, 'callback_status') AS callback_status
      , JSONExtractString(_airbyte_data, 'delay_provider_submission_date') AS delay_provider_submission_date
FROM 
      source