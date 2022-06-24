 SELECT events.product_id
        , products.name as product_name
        , COUNT(DISTINCT events.session_id) as sessions_with_product_view
 FROM {{ ref('stg_events') }} AS events
 LEFT JOIN {{ ref('stg_products') }} AS products ON events.product_id = products.product_id
 WHERE events.event_type = 'page_view'
 GROUP BY 1, 2

