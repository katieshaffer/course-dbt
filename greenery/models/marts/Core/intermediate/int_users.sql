WITH repeat_customers AS
    (SELECT orders.user_id, COUNT(DISTINCT order_id) as number_of_user_orders
     FROM {{ ref('stg_orders' ) }} as orders
     GROUP BY orders.user_id
     HAVING COUNT(DISTINCT order_id) > 1
    )

SELECT 
    users.user_id
    , CASE WHEN repeat_customers.user_id IS NOT NULL THEN true ELSE false END AS is_repeat_customer
    , repeat_customers.number_of_user_orders
    , users.first_name
    , users.last_name
    , users.email
    , users.phone_number
    , users.created_at as user_created_at
FROM {{ ref('stg_users') }} AS users
LEFT JOIN repeat_customers ON users.user_id = repeat_customers.user_id