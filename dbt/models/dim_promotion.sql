{{
  config(
    materialized='table'
  )
}}

WITH promo AS (
SELECT
  DISTINCT COALESCE(`promotion-ids`, '-') AS promotions
FROM 
  `dibimbing-de.dibimbing.amazon-sale-report`
)

SELECT 
{{ dbt_utils.generate_surrogate_key([
				'promotions'
			])}} AS promotion_id,
             *
FROM promo