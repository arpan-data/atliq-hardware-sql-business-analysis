/*=====================================================================
Project         : AtliQ Hardware SQL Business Analysis

Report          : Monthly Sales Trend Analysis

Business User   : Sales Manager / Finance Manager

Business Requirement:
Analyze monthly net sales performance for Fiscal Year 2021
to identify sales trends, seasonal patterns, and
month-over-month (MoM) growth.

Business Goal:
Monitor monthly sales performance to support demand
forecasting, inventory planning, budgeting, and
strategic business decision-making.

Business Metrics:
- Monthly Net Sales (Million)
- Running Total (Million)
- Previous Month Sales (Million)
- Month-over-Month (MoM) Growth (%)

Required Output:
- Fiscal Year
- Month
- Monthly Net Sales (Million)
- Running Total (Million)
- Previous Month Sales (Million)
- Month-over-Month (MoM) Growth (%)

SQL Concepts Used:
- SQL View
- Common Table Expression (CTE)
- Aggregate Function (SUM)
- Window Function
- SUM() OVER()
- LAG()
- Business KPI Calculation
- CASE
- ROUND
- ORDER BY

Author          : Arpan Das
=====================================================================*/

WITH monthly_sales AS (

    SELECT
        fiscal_year,
        MONTH(date) AS month_no,
        MONTHNAME(date) AS month_name,

        -- Calculate Monthly Net Sales
        SUM(net_sales) AS monthly_net_sales

    FROM net_sales

    WHERE fiscal_year = 2021

    GROUP BY
        fiscal_year,
        MONTH(date),
        MONTHNAME(date)

),

sales_trend AS (

    SELECT
        fiscal_year,
        month_no,
        month_name,
        monthly_net_sales,

        -- Running Total
        SUM(monthly_net_sales)
            OVER (
                ORDER BY month_no
            ) AS running_total,

        -- Previous Month Net Sales
        LAG(monthly_net_sales)
            OVER (
                ORDER BY month_no
            ) AS previous_month_sales

    FROM monthly_sales

)

SELECT

    fiscal_year AS `Fiscal Year`,
    month_name AS `Month`,

    ROUND(monthly_net_sales / 1000000, 2)
        AS `Monthly Net Sales (Million)`,

    ROUND(running_total / 1000000, 2)
        AS `Running Total (Million)`,

    ROUND(previous_month_sales / 1000000, 2)
        AS `Previous Month Sales (Million)`,

    CASE
        WHEN previous_month_sales IS NULL THEN NULL
        WHEN previous_month_sales = 0 THEN NULL

        ELSE ROUND(
            (
                (monthly_net_sales - previous_month_sales)
                * 100
            ) / previous_month_sales,
            2
        )

    END AS `Month-over-Month Growth (%)`

FROM sales_trend

ORDER BY
    month_no;