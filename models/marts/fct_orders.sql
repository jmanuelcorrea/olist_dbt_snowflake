with items as (
    select
        order_id,
        count(*)                       as items_count,
        count(distinct product_id)     as distinct_products_count,
        sum(price)                     as items_total,
        sum(freight_value)             as freight_total
    from {{ ref('stg_olist__order_items') }}
    group by order_id
),

payments as (
    select
        order_id,
        count(*)            as payments_count,
        sum(payment_value)  as payments_total
    from {{ ref('stg_olist__order_payments') }}
    group by order_id
),

reviews as (
    select
        order_id,
        count(*)            as reviews_count,
        avg(review_score)   as avg_review_score
    from {{ ref('stg_olist__order_reviews') }}
    group by order_id
)

select
    o.order_id,
    o.customer_id,
    o.order_status,
    o.order_purchased_at,
    o.order_approved_at,
    o.order_delivered_to_carrier_at,
    o.order_delivered_to_customer_at,
    o.order_estimated_delivery_at,
    datediff(day, o.order_purchased_at, o.order_delivered_to_customer_at)  as days_to_deliver,
    coalesce(i.items_count, 0)               as items_count,
    coalesce(i.distinct_products_count, 0)   as distinct_products_count,
    coalesce(i.items_total, 0)               as items_total,
    coalesce(i.freight_total, 0)             as freight_total,
    coalesce(p.payments_count, 0)            as payments_count,
    coalesce(p.payments_total, 0)            as payments_total,
    coalesce(r.reviews_count, 0)             as reviews_count,
    r.avg_review_score
from {{ ref('stg_olist__orders') }} as o
left join items    as i on o.order_id = i.order_id
left join payments as p on o.order_id = p.order_id
left join reviews  as r on o.order_id = r.order_id
