-- The raw model represents the data as it comes directly from the source, with minimal to no transformations.

{{
	config(
		materialized='table'
	) 
}}

SELECT *
FROM {{ source('airbyte_internal', 'raw_raw__stream_bahigo_altpay_deposit') }}