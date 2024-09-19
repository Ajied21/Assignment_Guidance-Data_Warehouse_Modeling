{{
  config(
    materialized='table'
  )
}}

WITH shipment AS (
SELECT
  DISTINCT
  `ship-postal-code` AS ship_postal_code,
  `ship-city` AS ship_city,
  `ship-state` AS ship_state,
  `ship-country` AS ship_country,
  `ship-service-level` AS ship_service_level,
  `Courier Status` AS courier_status
FROM
  `dibimbing-de.dibimbing.amazon-sale-report`
WHERE
  NOT (`ship-postal-code` IS NULL OR 
       `ship-city` IS NULL OR 
       `ship-state` IS NULL OR 
       `ship-country` IS NULL
      )
) -- pada where untuk mengurangi data dari null itu hanya berkurang sekitar 5 rows dari 32738 ke 32733

SELECT 
{{ dbt_utils.generate_surrogate_key([
				'ship_postal_code',
        'ship_city',
        'ship_state',
        'ship_country'
			])}} AS sales_shipment_id,
             *
FROM shipment