{{ config(tags=["shopify"]) }}

with source as (
    select * from {{ ref('raw_shopify_sales') }}
),
staging as (
    select
        region,
        country,
        itemtype as item_type,
        saleschannel as sales_channel,
        orderpriority as order_priority,
        TO_DATE(orderdate, 'MM/DD/YYYY') as order_data,
        orderid as order_id,
        TO_DATE(shipdate,'MM/DD/YYYY') as ship_date,
        unitssold as unit_sold,
        unitprice as unit_price,
        unitcost as unit_cost,
        totalrevenue as total_revenue,
        totalcost as total_cost,
        totalprofit as total_profit
    from source
)
select * from staging