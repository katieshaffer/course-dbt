SELECT 
    events.event_id
    , events.session_id
    , events.user_id
    , events.event_type
    , events.page_url
    , events.created_at
    , CASE WHEN events.order_id IS NOT NULL THEN 'Y' ELSE 'N' END AS linked_to_an_order
    , events.order_id
    , events.product_id
    , products.name as product_name
FROM {{ ref('stg_events') }} AS events
LEFT JOIN {{ ref('stg_products') }} AS products ON events.product_id = products.product_id