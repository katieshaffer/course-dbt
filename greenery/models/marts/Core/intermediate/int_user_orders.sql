WITH repeat_customers AS
    (SELECT orders.user_id, COUNT(DISTINCT order_id) as number_of_user_orders
     FROM {{ ref('stg_orders' ) }} as orders
     GROUP BY orders.user_id
     HAVING COUNT(DISTINCT order_id) > 1
    )

SELECT 
    orders.order_id
    , orders.user_id
    , CASE WHEN repeat_customers.user_id IS NOT NULL THEN true ELSE false END AS is_repeat_customer
    , users.first_name
    , users.last_name
    , users.email
    , users.phone_number
    , users.created_at as user_created_at
    , orders.address_id as order_address_id
    , orders.created_at as order_created_at
    , orders.order_cost
    , orders.shipping_cost
    , orders.order_total as order_total_cost
    , orders.status as order_status
    , orders.tracking_id
    , orders.shipping_service
    , orders.estimated_delivery_at
    , orders.delivered_at
FROM {{ ref('stg_orders') }} AS orders
JOIN {{ ref('stg_users' )}} AS users ON users.user_id = orders.user_id
JOIN {{ ref('stg_order_items')}} as items ON orders.order_id = items.order_id
LEFT JOIN repeat_customers ON users.user_id = repeat_customers.user_id