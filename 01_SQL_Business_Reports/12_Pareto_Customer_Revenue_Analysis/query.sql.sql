/*=====================================================================
Project         : AtliQ Hardware SQL Business Analysis

Report          : Pareto Customer Revenue Analysis (80/20 Rule)

Business User   : Sales Director / Finance Manager

Business Requirement:
Analyze customer revenue contribution to determine whether
a small percentage of customers generates the majority
of total net sales.

Business Goal:
Apply the Pareto (80/20) principle to identify high-value
customers and support customer prioritization, retention,
and strategic sales planning.

Business Metrics:
- Net Sales (Million)
- Contribution (%)
- Cumulative Contribution (%)
- Pareto Category

Required Output:
- Customer
- Net Sales (Million)
- Contribution (%)
- Cumulative Contribution (%)
- Pareto Category

SQL Concepts Used:
- SQL View
- Common Table Expression (CTE)
- Window Function
- Running Total
- Cumulative Percentage
- Aggregate Function (SUM)
- CASE
- ROUND

Author          : Arpan Das
=====================================================================*/

WITH customer_sales AS (

    SELECT
        c.customer,
        ROUND(SUM(s.net_sales) / 1000000, 2) AS net_sales_mln
    FROM net_sales AS s
    INNER JOIN dim_customer AS c
        ON s.customer_code = c.customer_code
    WHERE s.fiscal_year = 2021
    GROUP BY c.customer

),

pareto_calculation AS (

    SELECT
        customer,
        net_sales_mln,

        -- Individual customer contribution
        ROUND(
            (net_sales_mln * 100)
            / SUM(net_sales_mln) OVER (),
            2
        ) AS contribution_pct,

        -- Running total of revenue
        SUM(net_sales_mln) OVER (
            ORDER BY net_sales_mln DESC
            ROWS BETWEEN UNBOUNDED PRECEDING
            AND CURRENT ROW
        ) AS running_total_mln,

        -- Total revenue
        SUM(net_sales_mln) OVER () AS total_sales_mln

    FROM customer_sales

),

pareto_analysis AS (

    SELECT
        customer,
        net_sales_mln,
        contribution_pct,

        ROUND(
            (running_total_mln * 100)
            / total_sales_mln,
            2
        ) AS cumulative_contribution_pct

    FROM pareto_calculation

)

SELECT
    customer,
    net_sales_mln,
    contribution_pct,
    cumulative_contribution_pct,

    CASE
        WHEN cumulative_contribution_pct <= 80
            THEN 'Top 80% Revenue (Core Accounts)'

        WHEN cumulative_contribution_pct <= 95
            THEN 'Next 15% Revenue (Growth Partners)'

        ELSE 'Remaining Customers (Long Tail)'

    END AS pareto_category

FROM pareto_analysis

ORDER BY
    net_sales_mln DESC;