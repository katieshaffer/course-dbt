SELECT events_agg.session_id
        , events_agg.user_id
        , events_agg.page_view
        , events_agg.created_at
        , events_agg.page_url
FROM {{ ref('int_session_events_funnel') }} AS events_agg