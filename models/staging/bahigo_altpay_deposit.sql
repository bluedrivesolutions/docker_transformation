{{
	config(
		materialized='table'
	) 
}}

SELECT *
FROM {{ source('airbyte_internal', 'raw_raw__stream_bahigo_altpay_deposit') }}