{{ config(tags=["salesforce"]) }}

with source as (
    select * from {{ ref('raw_shopify_sales') }}
),
staging as (
    select
        "Region" as region,
        "Country" as country,
        "ItemType" as item_type,
        "SalesChannel" as sales_channel,
        "OrderPriority" as order_priority,
        TO_DATE("OrderDate", 'MM/DD/YYYY') as order_data,
        "OrderID" as order_id,
        TO_DATE("ShipDate",'MM/DD/YYYY') as ship_date,
        "UnitsSold" as unit_sold,
        "UnitPrice" as unit_price,
        "UnitCost" as unit_cost,
        "TotalRevenue" as total_revenue,
        "TotalCost" as total_cost,
        "TotalProfit" as total_profit
    from source
)
select * from staging