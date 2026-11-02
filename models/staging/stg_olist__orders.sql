select
    order_id,
    customer_id,
    order_status,
    try_to_timestamp_ntz(nullif(trim(order_purchase_timestamp), ''))        as order_purchased_at,
    try_to_timestamp_ntz(nullif(trim(order_approved_at), ''))               as order_approved_at,
    try_to_timestamp_ntz(nullif(trim(order_delivered_carrier_date), ''))    as order_delivered_to_carrier_at,
    try_to_timestamp_ntz(nullif(trim(order_delivered_customer_date), ''))   as order_delivered_to_customer_at,
    try_to_timestamp_ntz(nullif(trim(order_estimated_delivery_date), ''))   as order_estimated_delivery_at
from {{ source('olist', 'orders') }}
