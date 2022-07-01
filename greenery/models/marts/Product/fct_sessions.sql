WITH session_length AS (
    SELECT session_id
            , MIN(created_at) AS first_event
            , MAX(created_at) AS last_event
    FROM {{ ref('stg_events') }} AS events
    GROUP BY session_id
)

SELECT events_totals.session_id
        , events_totals.user_id
        , users.first_name
        , users.last_name
        , users.email
        , events_totals.page_view AS session_page_view_events
        , events_totals.add_to_cart AS session_add_to_cart_events
        , events_totals.checkout AS session_checkout_events
        , events_totals.package_shipped AS session_package_shipped_events
        , session_length.first_event
        , session_length.last_event
        , (DATE_PART('DAY', session_length.last_event::timestamp - session_length.first_event::timestamp) * 24 +
    DATE_PART('HOUR', session_length.last_event::timestamp - session_length.first_event::timestamp)) * 60 +
    DATE_PART('MINUTE', session_length.last_event::timestamp - session_length.first_event::timestamp)
    AS session_length_minutes
FROM {{ ref('int_session_events_totals') }} AS events_totals
LEFT JOIN {{ ref('stg_users') }} AS users ON events_totals.user_id = users.user_id
LEFT JOIN session_length ON events_totals.session_id = session_length.session_id