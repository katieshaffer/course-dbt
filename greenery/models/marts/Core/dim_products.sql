SELECT 
    product_id
    , product_name
    , price
    , is_in_stock
    , number_in_stock
    , number_of_orders_with_product
FROM {{ ref('int_products') }}