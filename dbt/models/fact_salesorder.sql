{{config( materialized='table')}}

WITH fact AS (
SELECT
*
FROM 
  `dibimbing-de.dibimbing.amazon-sale-report` 
WHERE
  NOT (`ship-postal-code` IS NULL OR 
       `ship-city` IS NULL OR 
       `ship-state` IS NULL OR 
       `ship-country` IS NULL
      )
)

SELECT
  index,
  `Order ID` AS order_id,
  {{ dbt_utils.generate_surrogate_key([
			 'Fulfilment', 
			 '`fulfilled-by`'
			])}} AS fulfilment_id,
  {{ dbt_utils.generate_surrogate_key([
				'SKU'
			])}} AS product_id,
  {{ dbt_utils.generate_surrogate_key([
				'`promotion-ids`'
			])}} AS promotion_id,
  {{ dbt_utils.generate_surrogate_key([
				'`Sales Channel `'
			])}} AS sales_channel_id,
  {{ dbt_utils.generate_surrogate_key([
        '`ship-postal-code`',
        '`ship-city`',
        '`ship-state`',
        '`ship-country`'
			])}} AS sales_shipment_id,
  ASIN AS asin,
  Date AS date,
  Status AS status,
  B2B AS b2b,
  Qty AS qty,
  Amount AS amount
FROM 
  fact