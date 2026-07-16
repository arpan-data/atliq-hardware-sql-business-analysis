/*=====================================================================
Project        : AtliQ Hardware SQL Business Analysis

Report         : Croma Monthly Total Gross Sales Report

Business User  : Product Owner

Business Requirement:
Generate a monthly total gross sales report for Croma India.

Business Goal:
Analyze monthly gross sales trends to evaluate sales performance,
identify seasonal patterns, and support business decision-making.

Business Metrics:
- Gross Sales

Required Output:
- Date
- Monthly Gross Sales

SQL Concepts Used:
- INNER JOIN
- Aggregation (SUM)
- User Defined Function (UDF)
- GROUP BY
- ORDER BY

Author         : Arpan Das
=====================================================================*/

-- Calculate monthly total gross sales for Croma India

SELECT
    s.date,
    ROUND(SUM(s.sold_quantity * g.gross_price), 2) AS monthly_gross_sales
FROM fact_sales_monthly AS s
INNER JOIN fact_gross_price AS g
    ON s.product_code = g.product_code
   AND g.fiscal_year = GET_FISCAL_YEAR(s.date)
WHERE s.customer_code = 90002002
GROUP BY s.date
ORDER BY s.date;