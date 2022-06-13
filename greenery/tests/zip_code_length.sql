   select address_id
          , zipcode
          , length(zipcode::text)
          , state
   from {{ ref('stg_addresses') }}
   having length(zipcode::text) < 5

/* Zip codes should be either 5 characters long (expected) or 4 characters long (if a leading zero was dropped for a New England address)