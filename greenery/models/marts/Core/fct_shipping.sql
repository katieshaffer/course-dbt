SELECT 
    shipping.order_id 
    , shipping.address_id
    , shipping.address
    , shipping.zipcode
    , shipping.state
    , shipping.country
    , shipping.is_usa
    , shipping.shipping_cost
    , shipping.tracking_id
    , shipping.shipping_service
    , shipping.status
    , shipping.created_at
    , {{ dbt_date.month_name("created_at") }} as month_order_created
    , {{ dbt_date.day_name("created_at") }} as day_order_created
    , CASE WHEN date_trunc('day', shipping.estimated_delivery_at) > date_trunc('day', shipping.delivered_at) THEN 'Early'
       WHEN  date_trunc('day', shipping.estimated_delivery_at) < date_trunc('day', shipping.delivered_at) THEN 'Late'
       WHEN  date_trunc('day', shipping.estimated_delivery_at) = date_trunc('day', shipping.delivered_at)  THEN 'On Time'
       ELSE NULL END as delivery_timeliness
    , delivered_at::date - created_at::date AS days_from_order_to_delivery
FROM {{ ref('int_shipping') }} AS shipping
