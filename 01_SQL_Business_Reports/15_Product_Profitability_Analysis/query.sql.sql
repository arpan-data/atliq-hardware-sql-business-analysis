/*=====================================================================
Project         : AtliQ Hardware SQL Business Analysis

Report          : Product Profitability & Manufacturing Margin Analysis

Business User   : CFO / Product Strategy Director

Business Requirement:
Analyze product profitability for Fiscal Year 2021 by comparing
net sales with manufacturing cost.

Business Goal:
Evaluate product profitability to identify high-margin and
low-margin products, supporting pricing strategy, cost
optimization, and product portfolio decisions.

Business Metrics:
- Net Sales (Million)
- Manufacturing Cost (Million)
- Estimated Gross Profit (Million)
- Estimated Gross Margin (%)

Required Output:
- Segment
- Product
- Net Sales (Million)
- Manufacturing Cost (Million)
- Estimated Gross Profit (Million)
- Estimated Gross Margin (%)

SQL Concepts Used:
- Common Table Expression (CTE)
- INNER JOIN
- Aggregate Function (SUM)
- Business KPI Calculation
- Mathematical Margin Calculation
- CASE
- ORDER BY

Author          : Arpan Das
=====================================================================*/

WITH product_financials AS (

    SELECT
        p.segment,
        p.product,

        -- Total Net Sales
        SUM(s.net_sales) AS net_sales,

        -- Total Manufacturing Cost
        SUM(s.sold_quantity * mc.manufacturing_cost) AS manufacturing_cost

    FROM net_sales AS s

    INNER JOIN dim_product AS p
        ON s.product_code = p.product_code

    INNER JOIN fact_manufacturing_cost AS mc
        ON s.product_code = mc.product_code
       AND s.fiscal_year = mc.cost_year

    WHERE s.fiscal_year = 2021

    GROUP BY
        p.segment,
        p.product

),

margin_analysis AS (

    SELECT
        segment,
        product,
        net_sales,
        manufacturing_cost,

        (net_sales - manufacturing_cost)
            AS estimated_gross_profit

    FROM product_financials

)

SELECT

    segment,
    product,

    ROUND(net_sales / 1000000, 2)
        AS `Net Sales (Million)`,

    ROUND(manufacturing_cost / 1000000, 2)
        AS `Manufacturing Cost (Million)`,

    ROUND(estimated_gross_profit / 1000000, 2)
        AS `Estimated Gross Profit (Million)`,

    CASE
        WHEN net_sales = 0 THEN NULL
        ELSE ROUND(
            (estimated_gross_profit * 100) / net_sales,
            2
        )
    END AS `Estimated Gross Margin (%)`

FROM margin_analysis

ORDER BY
    estimated_gross_profit DESC,
    segment,
    product;