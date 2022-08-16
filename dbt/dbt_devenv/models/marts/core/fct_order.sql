{{ config(tags=["shopify"]) }}

with location as (
    select * from {{ ref('dim_location') }}
),
orders as (
    select * from {{ ref('stg_shopify__sales') }}
),
final as (
    select
        order_id,
        location.id as location_id,
        item_type,
        sales_channel,
        order_priority,
        order_data,
        ship_date,
        unit_sold,
        unit_price,
        unit_cost,
        total_revenue,
        total_cost,
        total_profit
    from orders
    inner join location using(country)
)
select * from final
