SELECT 
    address_id
    , address
    /* If zip code has length of 4, assume it has a dropped zero and add the zero back in*/
    , CASE WHEN LENGTH(zipcode::text) = 4 THEN CONCAT(0, zipcode) ELSE zipcode::text END AS zipcode
    , state
    , country
    /* Add flag to easily distinguish US orders vs. international orders */
    , CASE WHEN country = 'United States' THEN true ELSE false END AS is_usa
FROM {{ ref('stg_addresses') }}