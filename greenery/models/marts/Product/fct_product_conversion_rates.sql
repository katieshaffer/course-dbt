
SELECT product_views.product_id
      , product_views.product_name
      , product_views.sessions_with_product_view
      , product_purchases.sessions_with_product_purchase
      , ROUND(product_purchases.sessions_with_product_purchase::numeric / product_views.sessions_with_product_view::numeric * 100, 2) as product_conversion_rate
FROM {{ ref ('int_product_page_views') }} as product_views
JOIN {{ ref ('int_product_purchases') }} AS product_purchases ON product_views.product_id = product_purchases.product_id
