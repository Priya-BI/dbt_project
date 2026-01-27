{{ config(materialized='table') }}
with stores AS (
select 
        store_sk,
        store_name,
        city,
        state_province,
        country
    from 
    {{ ref('bronze_store') }}
),

sales AS (
select 
        store_sk,
        sum(gross_amount) as total_storesales
    from
    {{ ref('bronze_sales') }}
    GROUP BY
        store_sk
    ORDER BY
        store_sk ASC

)   

(
    SELECT 
        sales.store_sk,
        sales.total_storesales,
        stores.store_name,  
        stores.city,
        stores.state_province,
        stores.country
    FROM sales
    LEFT JOIN stores
        ON sales.store_sk = stores.store_sk   
        ORDER BY sales.store_sk ASC     
)


