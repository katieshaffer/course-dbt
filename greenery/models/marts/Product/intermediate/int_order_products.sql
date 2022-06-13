SELECT 
    orders.order_id
    , orders.user_id
    , orders.address_id
    , orders.created_at
    , orders.order_total as order_total_cost
    , orders.status
    , products.product_id
    , products.name as product_name
    , products.price as product_price
    , items.quantity as product_quantity
FROM {{ ref('stg_orders') }} AS orders
JOIN {{ ref('stg_order_items')}} as items ON orders.order_id = items.order_id
JOIN {{ ref('stg_products')}} AS products on items.product_id = products.product_id