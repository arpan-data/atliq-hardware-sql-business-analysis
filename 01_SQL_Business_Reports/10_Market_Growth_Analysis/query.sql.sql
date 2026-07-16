/*=====================================================================
Project         : AtliQ Hardware SQL Business Analysis

Report          : Market Growth Analysis

Business User   : Sales Director / Regional Sales Manager

Business Requirement:
Analyze year-over-year net sales growth across markets
to identify high-growth and declining markets.

Business Goal:
Compare market performance between Fiscal Year 2020
and Fiscal Year 2021 to identify high-growth and
declining markets, supporting strategic planning,
resource allocation, and market expansion decisions.

Business Metrics:
- Net Sales FY2020 (Million)
- Net Sales FY2021 (Million)
- Growth (Million)
- Growth (%)

Required Output:
- Market
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

WITH market_sales_pivot AS (

    SELECT
        c.market,

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
    INNER JOIN dim_customer AS c
        ON s.customer_code = c.customer_code

    WHERE s.fiscal_year IN (2020, 2021)

    GROUP BY c.market

),

market_growth AS (

    SELECT
        market,
        net_sales_2020_mln,
        net_sales_2021_mln,
        ROUND(
            net_sales_2021_mln - net_sales_2020_mln,
            2
        ) AS growth_mln

    FROM market_sales_pivot

)

SELECT
    market,
    net_sales_2020_mln AS `Net Sales FY2020 (Million)`,
    net_sales_2021_mln AS `Net Sales FY2021 (Million)`,
    growth_mln AS `Growth (Million)`,

    CASE
        WHEN net_sales_2020_mln = 0 THEN 0
        ELSE ROUND(
            (growth_mln * 100) / net_sales_2020_mln,
            2
        )
    END AS `Growth (%)`

FROM market_growth

ORDER BY
    growth_mln DESC,
    market;