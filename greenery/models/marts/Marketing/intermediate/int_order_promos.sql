SELECT 
    orders.order_id
    , CASE WHEN orders.promo_id IS NOT NULL THEN true
            ELSE false END AS has_promo_code
    , promos.promo_id
    , promos.discount AS promo_discount
    , orders.user_id
    , orders.address_id
    , orders.created_at
    , orders.order_cost
    , orders.shipping_cost
    , orders.order_total
    , orders.tracking_id
    , orders.shipping_service
    , orders.estimated_delivery_at
    , orders.delivered_at
    , orders.status AS delivery_status
FROM {{ ref('stg_orders') }} AS orders
LEFT JOIN {{ ref('stg_promos') }} AS promos ON orders.promo_id = promos.promo_id