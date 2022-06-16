SELECT users.user_id
    , users.is_repeat_customer
    , users.number_of_user_orders
    , users.first_name
    , users.last_name
    , users.email
    , users.phone_number
    , users.user_created_at
FROM {{ ref('int_users')}} AS users