{{
  config(
    materialized='table'
  )
}}

WITH channel AS (
SELECT
  DISTINCT `Sales Channel ` AS sales_channel
FROM
  `dibimbing-de.dibimbing.amazon-sale-report`
)

SELECT 
{{ dbt_utils.generate_surrogate_key([
				'Sales_channel'
			])}} AS sales_channel_id,
             *
FROM channel