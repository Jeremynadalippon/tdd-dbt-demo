with  __dbt__cte__fact_emails as (

-- Fixture for fact_emails
select cast(null as integer) as email_id, cast(null as text) as object, 
    
    cast('toto@ippon.fr' as text)
 as sender_address, 
    
    cast('2021-01-01 00:00:00' as timestamp without time zone)
 as received_at
union all
select cast(null as integer) as email_id, cast(null as text) as object, 
    
    cast('titi@ippon.fr' as text)
 as sender_address, 
    
    cast('2021-01-01 00:30:00' as timestamp without time zone)
 as received_at
union all
select cast(null as integer) as email_id, cast(null as text) as object, 
    
    cast('tata@google.com' as text)
 as sender_address, 
    
    cast('2021-01-01 00:00:00' as timestamp without time zone)
 as received_at
), emails as (
    select * from __dbt__cte__fact_emails
    
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