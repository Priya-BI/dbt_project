WITH returns AS
(
    SELECT
        salesid,
        date_sk,
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
)

SELECT
    returns.salesid,
    returns.product_sk,
    returns.returned_qty,
    returns.refund_amount,
    products.product_name,
    products.category,
    products.list_price
    FROM
    returns
    LEFT JOIN sales ON returns.salesid = sales.sales_id
    LEFT JOIN products ON returns.product_sk = products.product_sk