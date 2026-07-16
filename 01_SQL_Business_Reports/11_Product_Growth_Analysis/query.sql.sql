/*=====================================================================
Project         : AtliQ Hardware SQL Business Analysis

Report          : Product Growth Analysis

Business User   : Product Manager / Sales Manager

Business Requirement:
Analyze year-over-year net sales growth for products
to identify high-growth and declining products.

Business Goal:
Compare product performance between Fiscal Year 2020
and Fiscal Year 2021 to identify high-growth and
declining products, supporting product strategy,
inventory planning, and marketing decisions.

Business Metrics:
- Net Sales FY2020 (Million)
- Net Sales FY2021 (Million)
- Growth (Million)
- Growth (%)

Required Output:
- Division
- Product
- Net Sales FY2020 (Million)
- Net Sales FY2021 (Million)
- Growth (Million)
- Growth (%)

SQL Concepts Used:
- SQL View
- Common Table Expression (CTE)
- Conditional Aggregation (CASE WHEN)
- Aggregate Function (SUM)
- Business KPI Calculation
- CASE
- ROUND

Author          : Arpan Das
=====================================================================*/

WITH product_sales_pivot AS (

    SELECT
        p.division,
        p.product,

        -- Calculate FY2020 Net Sales
        ROUND(
            SUM(
                CASE
                    WHEN s.fiscal_year = 2020
                    THEN s.net_sales
                    ELSE 0
                END
            ) / 1000000,
            2
        ) AS net_sales_2020_mln,

        -- Calculate FY2021 Net Sales
        ROUND(
            SUM(
                CASE
                    WHEN s.fiscal_year = 2021
                    THEN s.net_sales
                    ELSE 0
                END
            ) / 1000000,
            2
        ) AS net_sales_2021_mln

    FROM net_sales AS s
    INNER JOIN dim_product AS p
        ON s.product_code = p.product_code

    WHERE s.fiscal_year IN (2020, 2021)

    GROUP BY
        p.division,
        p.product

),

product_growth AS (

    SELECT
        division,
        product,
        net_sales_2020_mln,
        net_sales_2021_mln,

        ROUND(
            net_sales_2021_mln - net_sales_2020_mln,
            2
        ) AS growth_mln

    FROM product_sales_pivot

)

SELECT
    division,
    product,
    net_sales_2020_mln AS `Net Sales FY2020 (Million)`,
    net_sales_2021_mln AS `Net Sales FY2021 (Million)`,
    growth_mln AS `Growth (Million)`,

    CASE
        WHEN net_sales_2020_mln = 0 THEN NULL
        ELSE ROUND(
            (growth_mln * 100) / net_sales_2020_mln,
            2
        )
    END AS `Growth (%)`

FROM product_growth

ORDER BY
    growth_mln DESC,
    division,
    product;