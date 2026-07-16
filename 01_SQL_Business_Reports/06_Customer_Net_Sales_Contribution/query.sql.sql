/*=====================================================================
Project         : AtliQ Hardware SQL Business Analysis

Report          : Customer Net Sales Contribution

Business User   : Sales Manager

Business Requirement:
Calculate each customer's contribution to the company's
total net sales for Fiscal Year 2021.

Business Goal:
Analyze customer revenue contribution to identify
high-value customers and support customer-focused
sales strategy and business decision-making.

Business Metrics:
- Net Sales (Million)
- Customer Contribution (%)

Required Output:
- Customer
- Net Sales (Million)
- Contribution (%)

SQL Concepts Used:
- SQL View
- Common Table Expression (CTE)
- Window Function
- Aggregate Function (SUM)
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

)

SELECT
    customer,
    net_sales_mln,
    ROUND(
        net_sales_mln * 100
        / SUM(net_sales_mln) OVER (),
        2
    ) AS contribution_pct
FROM customer_sales
ORDER BY net_sales_mln DESC;