{{
	config(
		materialized='table',
            tags=['streaming']
	) 
}}

WITH source AS (
      SELECT
            *
      FROM 
            {{ ref('raw_bahigo_altpay_payout') }}
      UNION ALL
      SELECT
            *
      FROM 
            {{ ref('raw_b10_altpay_payout') }}
)
SELECT 
      id
      , full_name
      , customer_email
      , account
      , amount
      , commission
      , signature
      , external_payout_id
      , internal_payout_id
      , external_user_id
      , redirect_complete_url
      , redirect_cancel_url
      , external_url
      , created
      , updated
      , last_decision
      , note
      , cancellation_reason
      , state
      , extra_data
      , currency_id
      , merchant_user_id
      , payout_type_id
      , settlement_commission
      , callback_status
      , delay_provider_submission_date

      -- , _airbyte_raw_id
      -- , _airbyte_data
      -- , _airbyte_extracted_at
      -- , _airbyte_loaded_at
FROM 
      source
