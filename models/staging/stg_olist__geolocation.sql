select
    geolocation_zip_code_prefix,
    try_to_double(geolocation_lat) as geolocation_lat,
    try_to_double(geolocation_lng) as geolocation_lng,
    nullif(trim(geolocation_city), '')  as geolocation_city,
    nullif(trim(geolocation_state), '') as geolocation_state
from {{ source('olist', 'geolocation') }}
