{{ config(tags=["shopify"]) }}

with location as (
    select
        distinct on (country)
        region,
        country
     from {{ ref('stg_shopify__sales') }}
     order by country
),
final as (
    select
        row_number() OVER () as id,
        region,
        country
    from location
)
select * from final