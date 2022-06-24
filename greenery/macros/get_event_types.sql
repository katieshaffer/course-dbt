{% macro get_event_types() %}
{{ return(["add_to_cart", "checkout", "page_view", "package_shipped"]) }}
{% endmacro %}