/*=====================================================================
Project         : AtliQ Hardware SQL Business Analysis

Report          : Top 3 Products by Division

Business User   : Product Manager / Sales Manager

Business Requirement:
Identify the top 3 products within each product division
based on net sales for Fiscal Year 2021.

Business Goal:
Analyze product performance across divisions to identify
top-performing products and support inventory planning,
pricing strategy, and product portfolio optimization.

Business Metrics:
- Net Sales (Million)
- Product Rank

Required Output:
- Division
- Product
- Net Sales (Million)
- Product Rank

SQL Concepts Used:
- SQL View
- Common Table Expression (CTE)
- Window Function
- DENSE_RANK()
- PARTITION BY
- Aggregate Function (SUM)
- ORDER BY

Author          : Arpan Das
=====================================================================*/

WITH product_sales AS (

    SELECT
        p.division,
        p.product,
        ROUND(SUM(s.net_sales) / 1000000, 2) AS net_sales_mln
    FROM net_sales AS s
    INNER JOIN dim_product AS p
        ON s.product_code = p.product_code
    WHERE s.fiscal_year = 2021
    GROUP BY
        p.division,
        p.product

),

ranked_products AS (

    SELECT
        division,
        product,
        net_sales_mln,
        DENSE_RANK() OVER (
            PARTITION BY division
            ORDER BY net_sales_mln DESC
        ) AS product_rank
    FROM product_sales

)

SELECT
    division,
    product,
    net_sales_mln,
    product_rank
FROM ranked_products
WHERE product_rank <= 3
ORDER BY
    division,
    product_rank,
    net_sales_mln DESC;