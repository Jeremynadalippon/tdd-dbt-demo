with emails as (
    select * from {{ ref('fact_emails') }}
)

, count_emails as (
    select
        date_trunc('hour', received_at) as sent_at_hour
        , substr(sender_address, position('@' in sender_address) + 1) as domain
        , count(*) as email_count
    from
        emails
    group by
        1, 2
)

select * from count_emails
