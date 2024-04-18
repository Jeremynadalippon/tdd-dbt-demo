with  __dbt__cte__agg_hourly_domain_emails as (

-- Fixture for agg_hourly_domain_emails
select 
    
    cast('''2021-01-01 00:00:00''' as timestamp without time zone)
 as sent_at_hour, cast(null as text) as domain, 
    
    cast('1' as bigint)
 as email_count
),  __dbt__cte__fact_emails as (

-- Fixture for fact_emails
select cast(null as integer) as email_id, cast(null as text) as object, cast(null as text) as sender_address, 
    
    cast('''2021-01-01 00:00:00''' as timestamp without time zone)
 as received_at
union all
select cast(null as integer) as email_id, cast(null as text) as object, cast(null as text) as sender_address, 
    
    cast('''2021-01-02 00:00:00''' as timestamp without time zone)
 as received_at
), emails as (
    select * from __dbt__cte__fact_emails
    
        where
            date_trunc('hour', received_at) > (select max(sent_at_hour) from __dbt__cte__agg_hourly_domain_emails)
    
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