select
    review_id || '|' || order_id                                      as review_order_id,
    review_id,
    order_id,
    try_to_number(review_score)                                       as review_score,
    nullif(trim(review_comment_title), '')                            as review_comment_title,
    nullif(trim(review_comment_message), '')                          as review_comment_message,
    try_to_timestamp_ntz(nullif(trim(review_creation_date), ''))      as review_created_at,
    try_to_timestamp_ntz(nullif(trim(review_answer_timestamp), ''))   as review_answered_at
from {{ source('olist', 'order_reviews') }}
