-- The raw model represents the data as it comes directly from the source, with minimal to no transformations.
-- Get the airbyte data.
-- Flatten the data already.

{{
	config(
		materialized='table',
            tags=['streaming', 'fact']
	) 
}}

WITH source AS (
      SELECT
            _airbyte_raw_id,
            _airbyte_data,
            _airbyte_extracted_at,
            _airbyte_loaded_at
      FROM 
            {{ source('airbyte_internal', 'raw_raw__stream_b10_altpay_deposit') }}
)
SELECT
      -- Airbyte metadata
      _airbyte_raw_id
      , _airbyte_data
      , _airbyte_extracted_at
      , _airbyte_loaded_at

      -- Extract fields from _airbyte_data
      , JSONExtractString(_airbyte_data, 'id') as deposit_id
      , JSONExtractString(_airbyte_data, 'full_name') as full_name
      , JSONExtractString(_airbyte_data, 'customer_email') as customer_email
      , JSONExtractString(_airbyte_data, 'account') as account
      , JSONExtractString(_airbyte_data, 'commission') as commission

      , JSONExtractString(_airbyte_data, 'external_user_id') as external_user_id
      , JSONExtractString(_airbyte_data, 'signature') as signature
      , JSONExtractString(_airbyte_data, 'external_deposit_id') as external_deposit_id
      , JSONExtractString(_airbyte_data, 'internal_deposit_id') as internal_deposit_id
      , JSONExtractString(_airbyte_data, 'redirect_deposit_id') as redirect_deposit_id

      , JSONExtractString(_airbyte_data, 'redirect_complete_url') as redirect_complete_url
      , JSONExtractString(_airbyte_data, 'redirect_cancel_url') as redirect_cancel_url
      , JSONExtractString(_airbyte_data, 'external_url') as external_url
      , JSONExtractString(_airbyte_data, 'destination_account_details') as destination_account_details
      , JSONExtractString(_airbyte_data, 'created') as created

      , JSONExtractString(_airbyte_data, 'updated') as updated
      , JSONExtractString(_airbyte_data, 'last_decision') as last_decision
      , JSONExtractString(_airbyte_data, 'state') as state
      , JSONExtractString(_airbyte_data, 'refunded') as refunded
      , JSONExtractString(_airbyte_data, 'note') as note

      , JSONExtractString(_airbyte_data, 'cancellation_reason') as cancellation_reason
      , JSONExtractString(_airbyte_data, 'extra_data') as extra_data
      , JSONExtractString(_airbyte_data, 'currency_id') as currency_id
      , JSONExtractString(_airbyte_data, 'deposit_type_id') as deposit_type_id
      , JSONExtractString(_airbyte_data, 'merchant_user_id') as merchant_user_id
      , JSONExtractString(_airbyte_data, 'settlement_commission') as settlement_commission

      , JSONExtractString(_airbyte_data, 'is_chargeback') as is_chargeback
      , JSONExtractString(_airbyte_data, 'callback_status') as callback_status
      , JSONExtractString(_airbyte_data, 'is_timeout') as is_timeout
      , JSONExtractString(_airbyte_data, 'cc_gateway_id') as cc_gateway_id
      , JSONExtractString(_airbyte_data, 'in_process') as in_process
FROM 
      source