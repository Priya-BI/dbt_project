{{ config(materialized='table') }}

with sales AS (
select 
        sales_id,
        product_sk,
        customer_sk,
        {{ multiply('unit_price', 'quantity') }} as calculated_gross_amount,
        gross_amount,
        payment_method
    from
    {{ ref('bronze_sales') }}
),

products AS
(
    select 
        product_sk,
        category
    from 
    {{ ref('bronze_product') }}
),

customers AS
(
    select 
        customer_sk,
        gender
    from 
    {{ ref('bronze_customers') }}
),

joined_query AS
(
    SELECT 
        sales.sales_id,
        sales.product_sk,
        sales.customer_sk,
        sales.calculated_gross_amount,
        sales.gross_amount,
        sales.payment_method,
        products.category,
        customers.gender 
    FROM sales
    LEFT JOIN products
        ON sales.product_sk = products.product_sk   
    LEFT JOIN customers
        ON sales.customer_sk = customers.customer_sk
)

SELECT
    category,
    gender,
    sum(gross_amount) AS total_sales
FROM 
    joined_query
GROUP BY
    category,
    gender
ORDER BY
    category DESC