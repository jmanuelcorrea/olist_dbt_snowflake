select
    customer_id,
    customer_unique_id,
    customer_zip_code_prefix,
    nullif(trim(customer_city), '')  as customer_city,
    nullif(trim(customer_state), '') as customer_state
from {{ source('olist', 'customers') }}
