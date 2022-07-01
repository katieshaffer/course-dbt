WITH events_agg AS 
    (
    SELECT events.session_id
    , events.created_at
    , events.user_id
    , events.page_url
    , SUM(CASE WHEN event_type = 'package shipped' THEN 1 ELSE 0 END) AS package_shipped
    , SUM(CASE WHEN event_type = 'page_view' THEN 1 ELSE 0 END) AS page_view
    , SUM(CASE WHEN event_type = 'checkout' THEN 1 ELSE 0 END) AS checkout
    , SUM(CASE WHEN event_type = 'add_to_cart' THEN 1 ELSE 0 END) AS add_to_cart
    FROM {{ ref('stg_events') }} AS events
    GROUP BY 1, 2, 3, 4
    )

SELECT session_id
    , created_at
    , user_id
    , page_url
    , package_shipped
    , page_view
    , checkout
    , add_to_cart
    , CASE WHEN page_view + checkout + add_to_cart > 0 THEN 1 ELSE 0 END AS view_checkout_or_cart_flag
    , CASE WHEN checkout + add_to_cart > 0 THEN 1 ELSE 0 END AS checkout_or_cart_flag
    , CASE WHEN checkout > 0 THEN 1 ELSE 0 END AS cart_flag
    , CASE WHEN checkout = 1 THEN 'Level 3'
      WHEN add_to_cart = 1 THEN 'Level 2'
      WHEN page_view = 1 THEN 'Level 1'
      ELSE NULL END AS funnel_stage
FROM events_agg

