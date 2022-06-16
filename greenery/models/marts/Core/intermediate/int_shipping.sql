SELECT 
    orders.order_id 
    , addresses.address_id
    , addresses.address
    /* If zip code has length of 4, assume it has a dropped zero and add the zero back in*/
    , CASE WHEN LENGTH(addresses.zipcode::text) = 4 THEN CONCAT(0, addresses.zipcode) ELSE zipcode::text END AS zipcode
    , addresses.state
    , addresses.country
    /* Add flag to easily distinguish US orders vs. international orders */
    , CASE WHEN addresses.country = 'United States' THEN true ELSE false END AS is_usa
    , orders.created_at
    , orders.shipping_cost
    , orders.tracking_id
    , orders.shipping_service
    , orders.status
    , orders.estimated_delivery_at
    , orders.delivered_at
FROM {{ ref('stg_addresses') }} AS addresses
JOIN {{ ref('stg_orders' ) }} AS orders ON addresses.address_id = orders.address_id