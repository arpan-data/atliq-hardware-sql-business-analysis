/*=====================================================================
Project        : AtliQ Hardware SQL Business Analysis

Report         : Customer Net Sales Contribution by Region

Business User  : Regional Sales Manager

Business Requirement:
Calculate each customer's contribution to total net sales
within each region for Fiscal Year 2021.

Business Goal:
Analyze customer revenue contribution across regions to
identify high-value customers and support regional sales
strategy.

Business Metrics:
- Net Sales (Million)
- Customer Contribution within Region (%)

Required Output:
- Customer
- Region
- Net Sales (Million)
- Region Contribution (%)

SQL Concepts Used:
- SQL Views
- Common Table Expression (CTE)
- Window Functions
- PARTITION BY
- Aggregation (SUM)
- ROUND

Author         : Arpan Das
=====================================================================*/
WITH customer_region_sales AS (
    SELECT
        c.customer,
        c.region,
        ROUND(SUM(s.net_sales) / 1000000, 2) AS net_sales_mln
    FROM net_sales AS s
    JOIN dim_customer AS c
        ON s.customer_code = c.customer_code
    WHERE s.fiscal_year = 2021
    GROUP BY
        c.customer,
        c.region
)

SELECT
    customer,
    region,
    net_sales_mln,
    ROUND(
        net_sales_mln * 100 /
        SUM(net_sales_mln) OVER (PARTITION BY region),
        2
    ) AS region_contribution_pct
FROM customer_region_sales
ORDER BY
    region,
    net_sales_mln DESC;