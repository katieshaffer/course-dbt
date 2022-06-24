 SELECT order_items.product_id
        , COUNT(DISTINCT events.session_id) as sessions_with_product_purchase
 FROM {{ ref('stg_events') }} AS events
 LEFT JOIN {{ ref('stg_order_items') }} AS order_items ON events.order_id = order_items.order_id
 WHERE events.event_type = 'checkout'
 GROUP BY order_items.product_id
 
  