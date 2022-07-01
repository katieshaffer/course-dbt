 SELECT date_trunc('month', created_at) as month
       , funnel_stage
       , COUNT(DISTINCT session_id) as session_count
FROM {{ ref('int_session_events_funnel') }}
WHERE funnel_stage IS NOT NULL
GROUP BY month
        , funnel_stage
