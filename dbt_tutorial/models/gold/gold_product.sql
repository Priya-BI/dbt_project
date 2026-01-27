{{ config(materialized='table') }}

with returns_silver AS (
select 
        category,
        total_refunds
    from 
    {{ ref('silver_returnsinfo') }}
),
sales_silver AS (
select 
        gender,
        category,
        total_sales 

    from 
    {{ ref('silver_salesinfo') }}
),
final_join AS (

SELECT
        returns_silver.category,
        returns_silver.total_refunds,
        sales_silver.total_sales
    FROM returns_silver 
    LEFT JOIN sales_silver 
        ON returns_silver.category = sales_silver.category
)

SELECT
        category,
        total_refunds,
        total_sales 
    FROM final_join
     ORDER BY category ASC