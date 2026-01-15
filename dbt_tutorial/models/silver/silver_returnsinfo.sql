WITH returns AS
(
    SELECT
        sales_id,
        date_sk,
        product_sk,
        returned_qty,
        refund_amount
    FROM {{ ref('bronze_returns') }}
),

sales AS
(
    SELECT
        sales_id,
        product_sk,
        customer_sk,
        store_sk,
        gross_amount
    FROM {{ ref('bronze_sales') }}
),

products AS
(
    SELECT
        product_sk,
        product_name,
        category,
        list_price
    FROM {{ ref('bronze_product') }}
),
joined_returns AS
(
SELECT
    returns.sales_id,
    returns.product_sk,  
    products.product_name,
    products.category,
    products.list_price,
    returns.returned_qty,
    returns.refund_amount
    FROM
    returns
    LEFT JOIN sales ON returns.sales_id = sales.sales_id
    LEFT JOIN products ON returns.product_sk = products.product_sk
    )

SELECT
    category,
    product_sk,
    sum(refund_amount) AS total_refunds
FROM 
    joined_returns
GROUP BY
    category,
    product_sk
ORDER BY
    category DESC