{{
  config(
    materialized='table'
  )
}}

WITH fulfill AS(
SELECT 
   DISTINCT Fulfilment AS fulfilment, 
   `fulfilled-by` AS fulfilled_by
FROM 
	`dibimbing-de.dibimbing.amazon-sale-report`
)

SELECT 
{{ dbt_utils.generate_surrogate_key([
				'fulfilment', 
				'fulfilled_by'
			])}} AS fulfilment_id,
             *
FROM fulfill