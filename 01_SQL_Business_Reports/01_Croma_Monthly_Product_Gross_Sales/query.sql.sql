/*=====================================================================
Project         : AtliQ Hardware SQL Business Analysis

Report          : Croma India FY2021 Monthly Product-wise Gross Sales

Business User   : Product Owner

Business Requirement:
Generate a monthly product-wise gross sales report for
Croma India for Fiscal Year 2021.

Business Goal:
Analyze monthly product-wise gross sales to identify
top-performing products and support inventory planning,
pricing strategy, and sales decision-making.

Dataset:
- fact_sales_monthly
- dim_product
- fact_gross_price

Author          : Arpan Das
=====================================================================*/

SELECT
    s.date,
    p.product_code,
    p.product,
    p.variant,
    s.sold_quantity,
    g.gross_price,
    ROUND(s.sold_quantity * g.gross_price, 2) AS gross_sales
FROM fact_sales_monthly AS s
INNER JOIN dim_product AS p
    ON p.product_code = s.product_code
INNER JOIN fact_gross_price AS g
    ON g.product_code = s.product_code
   AND g.fiscal_year = GET_FISCAL_YEAR(s.date)
WHERE s.customer_code = 90002002
  AND GET_FISCAL_YEAR(s.date) = 2021
ORDER BY gross_sales DESC;