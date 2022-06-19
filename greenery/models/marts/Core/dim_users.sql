
WITH first_and_last_order AS ( 
    SELECT user_id
           , MIN(created_at) AS first_order_created_at
           , MAX(created_at) AS most_recent_order_created_at
    FROM {{ ref('stg_orders')}}
    GROUP BY user_id
 )

SELECT users.user_id
    , users.is_repeat_customer
    , users.number_of_user_orders
    , users.first_name
    , users.last_name
    , users.email
    , users.phone_number
    , users.user_created_at
    , first_and_last_order.first_order_created_at
    , first_and_last_order.most_recent_order_created_at
FROM {{ ref('int_users')}} AS users
LEFT JOIN first_and_last_order ON users.user_id = first_and_last_order.user_id