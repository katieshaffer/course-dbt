SELECT 
    promo_id
    , discount
    , status
FROM {{ source('tutorial', 'promos') }}