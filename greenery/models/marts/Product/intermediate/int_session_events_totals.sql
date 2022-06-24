{%- set event_types = get_event_types() -%}

SELECT 
    events.session_id
    , events.user_id
    ,
    {%- for event_type in event_types %}
    SUM(CASE WHEN event_type = '{{event_type}}' THEN 1 ELSE 0 END) AS {{ event_type }}
    {%- if not loop.last %},{% endif -%}
    {% endfor %}

FROM {{ ref('stg_events') }} AS events
GROUP BY 1, 2