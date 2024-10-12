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
            {{ ref('raw_bahigo_altpay_deposit') }}
      UNION ALL
      SELECT
            *
      FROM 
            {{ ref('raw_b10_altpay_deposit') }}
)
SELECT 
      deposit_id
      , full_name
      , customer_email
      , account
      , commission
      , external_user_id
      , signature

      -- External deposit IDs
      , external_deposit_id
      , internal_deposit_id
      , redirect_deposit_id

      -- Redirect URLs
      , redirect_complete_url
      , redirect_cancel_url
      , external_url
      , destination_account_details
      , created
      , updated
      , last_decision
      , state
      , refunded
      , note
      , cancellation_reason
      , extra_data
      , currency_id
      , deposit_type_id
      , merchant_user_id
      , settlement_commission
      , is_chargeback
      , callback_status
      , is_timeout
      , cc_gateway_id
      , in_process

      -- , _airbyte_raw_id
      -- , _airbyte_data
      -- , _airbyte_extracted_at
      -- , _airbyte_loaded_at
FROM 
      source