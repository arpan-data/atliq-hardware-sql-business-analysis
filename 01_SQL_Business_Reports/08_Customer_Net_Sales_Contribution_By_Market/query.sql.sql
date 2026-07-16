/*=====================================================================
Project        : AtliQ Hardware SQL Business Analysis

Report         : Customer Net Sales Contribution by Market

Business User  : Sales Manager / Market Manager

Business Requirement:
Calculate each customer's contribution to total net sales
within each market for Fiscal Year 2021.

Business Goal:
Analyze customer revenue contribution across different
markets to identify key customers and support market-level
sales strategy.

Business Metrics:
- Net Sales (Million)
- Customer Contribution within Market (%)

Required Output:
- Customer
- Market
- Net Sales (Million)
- Market Contribution (%)

SQL Concepts Used:
- SQL Views
- Common Table Expression (CTE)
- Window Functions
- PARTITION BY
- Aggregation (SUM)
- ROUND

Author         : Arpan Das
=====================================================================*/
WITH customer_market_sales AS (
    SELECT
        c.customer,
        c.market,
        ROUND(SUM(s.net_sales) / 1000000, 2) AS net_sales_mln
    FROM net_sales AS s
    JOIN dim_customer AS c
        ON s.customer_code = c.customer_code
    WHERE s.fiscal_year = 2021
    GROUP BY
        c.customer,
        c.market
)

SELECT
    customer,
    market,
    net_sales_mln,
    ROUND(
        net_sales_mln * 100 /
        SUM(net_sales_mln) OVER (PARTITION BY market),
        2
    ) AS market_contribution_pct
FROM customer_market_sales
ORDER BY
    market,
    net_sales_mln DESC;