/*=====================================================================
Project         : AtliQ Hardware SQL Business Analysis

Report          : Croma Pre-Invoice Discount Report

Business User   : Sales Manager / Finance Team

Business Requirement:
Generate a detailed sales report for Croma India by including
the applicable pre-invoice discount percentage for each transaction.

Business Goal:
Analyze product-level gross sales along with pre-invoice discount
percentages to support pricing strategy, discount analysis,
and sales performance evaluation.

Business Metrics:
- Gross Sales
- Pre-Invoice Discount Percentage

Required Output:
- Date
- Product Code
- Product
- Variant
- Sold Quantity
- Gross Price per Item
- Gross Sales
- Pre-Invoice Discount Percentage

SQL Concepts Used:
- INNER JOIN
- User Defined Function (UDF)
- Calculated Columns
- WHERE Clause

Author          : Arpan Das
=====================================================================*/

SELECT
    s.date,
    s.product_code,
    p.product,
    p.variant,
    s.sold_quantity,
    g.gross_price AS gross_price_per_item,
    ROUND(s.sold_quantity * g.gross_price, 2) AS gross_sales,
    pre.pre_invoice_discount_pct AS pre_invoice_discount_percentage
FROM fact_sales_monthly AS s
INNER JOIN dim_product AS p
    ON s.product_code = p.product_code
INNER JOIN fact_gross_price AS g
    ON g.product_code = s.product_code
   AND g.fiscal_year = GET_FISCAL_YEAR(s.date)
INNER JOIN fact_pre_invoice_deductions AS pre
    ON pre.customer_code = s.customer_code
   AND pre.fiscal_year = GET_FISCAL_YEAR(s.date)
WHERE GET_FISCAL_YEAR(s.date) = 2021;