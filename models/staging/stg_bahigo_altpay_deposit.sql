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
            -- , _airbyte_data
            -- , _airbyte_extracted_at
            -- , _airbyte_loaded_at
            , deposit_id
            , full_name
            , customer_email
            , account
            , commission
            , user_id
            , signature
            , external_deposit_id
            , internal_deposit_id
            , redirect_deposit_id
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
      FROM 
            {{ ref('raw_bahigo_altpay_deposit') }}
)
SELECT 
      *
FROM 
      source