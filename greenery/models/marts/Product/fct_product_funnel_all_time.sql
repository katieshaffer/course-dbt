 with funnel_stage AS
      (
      SELECT funnel_stage
       , COUNT(DISTINCT session_id) as session_count
      FROM {{ ref('int_session_events_funnel') }}
      WHERE funnel_stage IS NOT NULL
      GROUP BY funnel_stage
      )

SELECT funnel_stage
      , session_count
      , ROUND(1 - (session_count::numeric / LAG(session_count::numeric,1) OVER (ORDER BY funnel_stage)),2) AS pct_drop_off_from_prior_level
FROM funnel_stage
