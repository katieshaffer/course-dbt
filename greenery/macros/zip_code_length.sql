{% test zip_code_length(model, column_name) %}

-- 5 digits is expected for zip code
-- If 4 digits, there is a step in intermediate model to add leading zero back to beginning of zip code to make it 5 digits
-- This test will identify if any zip codes are still not 5 digits after correction

select  {{ column_name }}, length( {{ column_name }}::text )
from {{ model }}
group by {{ column_name }}
having length( {{ column_name }}::text ) <> 5

{% endtest %}