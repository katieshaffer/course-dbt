select address_id
         , zipcode
         , length(zipcode::text)
         , state
from "dbt"."dbt_katie_s"."stg_addresses"
group by address_id, zipcode, state
having length(zipcode::text) NOT IN (4,5)