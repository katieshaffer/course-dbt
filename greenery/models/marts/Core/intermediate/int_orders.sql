SELECT 
    orders.order_id
    , orders.user_id
    , orders.address_id as order_address_id
    , orders.created_at as order_created_at
    , CASE WHEN orders.promo_id IS NOT NULL THEN true ELSE false END AS has_promo_code
    , promos.promo_id
    , promos.discount AS promo_discount
    , orders.order_cost
    , orders.shipping_cost
    , orders.order_total as order_total_cost
    , orders.status as order_status
    , orders.tracking_id
    , orders.shipping_service
    , orders.estimated_delivery_at
    , orders.delivered_at
FROM {{ ref('stg_orders') }} AS orders
LEFT JOIN {{ ref('stg_promos') }} AS promos ON orders.promo_id = promos.promo_id