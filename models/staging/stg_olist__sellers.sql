select
    seller_id,
    seller_zip_code_prefix,
    nullif(trim(seller_city), '')  as seller_city,
    nullif(trim(seller_state), '') as seller_state
from {{ source('olist', 'sellers') }}
