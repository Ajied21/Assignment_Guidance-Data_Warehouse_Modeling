{{
  config(
    materialized='table'
  )
}}

WITH product AS (
SELECT 
  DISTINCT
  Style AS style,
  SKU AS sku,
  Category AS category,
  Size AS size,
FROM
  `dibimbing-de.dibimbing.amazon-sale-report`

)

SELECT {{ dbt_utils.generate_surrogate_key([
				'sku'
			]) }} AS product_id, *
FROM product