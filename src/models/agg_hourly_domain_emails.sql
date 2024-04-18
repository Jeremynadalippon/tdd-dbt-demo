with emails as (
    select * from {{ ref('fact_emails') }}
    {% if is_incremental() %}
        where
            date_trunc('hour', received_at) > (select max(sent_at_hour) from {{ this }})
    {% endif %}
)

, count_emails as (
    select
        date_trunc('hour', received_at) as sent_at_hour
        , substring(sender_address from '@(.*)') as domain
        , count(*) as email_count
    from
        emails
    group by
        1, 2
)

select * from count_emails
