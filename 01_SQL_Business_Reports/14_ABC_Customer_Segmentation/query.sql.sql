/*=====================================================================
Project         : AtliQ Hardware SQL Business Analysis

Report          : ABC Customer Segmentation Report

Business User   : Sales Director / Customer Relationship Manager

Business Requirement:
Segment customers into A, B, and C categories based on their
cumulative contribution to total net sales for Fiscal Year 2021.

Business Goal:
Classify customers based on cumulative revenue contribution
to identify high-value accounts and support customer
retention, sales prioritization, marketing strategies,
and resource allocation.

Business Metrics:
- Net Sales (Million)
- Revenue Contribution (%)
- Cumulative Revenue (%)
- Customer Segment (A/B/C)

Required Output:
- Customer
- Market
- Region
- Net Sales (Million)
- Revenue Contribution (%)
- Cumulative Revenue (%)
- Customer Segment

SQL Concepts Used:
- SQL View
- Common Table Expression (CTE)
- Window Function
- SUM() OVER()
- Running Total
- Cumulative Percentage
- Aggregate Function (SUM)
- CASE
- Business Classification
- ROUND
- ORDER BY

Author          : Arpan Das
=====================================================================*/

WITH customer_sales AS (

    SELECT
        c.customer,
        c.market,
        c.region,
        SUM(s.net_sales) AS net_sales

    FROM net_sales AS s

    INNER JOIN dim_customer AS c
        ON s.customer_code = c.customer_code

    WHERE s.fiscal_year = 2021

    GROUP BY
        c.customer,
        c.market,
        c.region

),

customer_contribution AS (

    SELECT
        customer,
        market,
        region,
        net_sales,

        -- Running Total
        SUM(net_sales)
            OVER (
                ORDER BY net_sales DESC
            ) AS running_total,

        -- Total Revenue
        SUM(net_sales)
            OVER () AS total_sales

    FROM customer_sales

)

SELECT

    customer,
    market,
    region,

    ROUND(net_sales / 1000000, 2)
        AS `Net Sales (Million)`,

    ROUND(
        (net_sales * 100) / total_sales,
        2
    ) AS `Revenue Contribution (%)`,

    ROUND(
        (running_total * 100) / total_sales,
        2
    ) AS `Cumulative Revenue (%)`,

    CASE
        WHEN (running_total * 100) / total_sales <= 70
            THEN 'A'

        WHEN (running_total * 100) / total_sales <= 90
            THEN 'B'

        ELSE 'C'

    END AS `Customer Segment`

FROM customer_contribution

ORDER BY
    net_sales DESC;