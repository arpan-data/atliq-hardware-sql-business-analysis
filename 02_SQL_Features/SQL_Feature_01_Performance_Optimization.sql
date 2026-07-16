/*=====================================================================
Project        : AtliQ Hardware SQL Business Analysis

SQL Feature    : Performance Optimization

Objective:
Optimize SQL query performance by progressively improving
the fiscal year lookup process and reducing query execution time.

Optimization Journey:

Performance Improvement #1
- Created and utilized a reusable dim_date table.
- Replaced repeated get_fiscal_year() function calls
  with joins to the dim_date table.

Performance Improvement #2
- Utilized the fiscal_year column available in
  fact_sales_monthly.
- Eliminated the dim_date join for faster filtering
  and simpler query execution.

Benefits:
- Reduced function calls
- Simplified query logic
- Faster query execution
- Improved scalability

SQL Concepts Used:
- Data Modeling
- Date Dimension
- Query Optimization
- Join Optimization

Author         : Arpan Das
=====================================================================*/

-- This file demonstrates the evolution of a reporting query
-- through successive optimization techniques.
--
-- Version 1 : Date Dimension
-- Version 2 : Fiscal Year Column

/*=========================================================
Performance Improvement #1
Using dim_date for Fiscal Year Lookup
=========================================================*/
SELECT 
    s.date,
    s.customer_code,
    s.product_code,
    p.product,
    p.variant,
    s.sold_quantity,
    g.gross_price AS gross_price_per_item,
    ROUND(s.sold_quantity * g.gross_price, 2) AS gross_price_total,
    pre.pre_invoice_discount_pct
FROM
    fact_sales_monthly s
        JOIN
    dim_date dt ON dt.calendar_date = s.date
        JOIN
    dim_product p ON s.product_code = p.product_code
        JOIN
    fact_gross_price g ON g.fiscal_year = dt.fiscal_year
        AND g.product_code = s.product_code
        JOIN
    fact_pre_invoice_deductions AS pre ON pre.customer_code = s.customer_code
        AND pre.fiscal_year = dt.fiscal_year
WHERE
    dt.fiscal_year = 2021
LIMIT 1500000;

/**********************************************************
Performance Improvement #2
Using fiscal_year in fact_sales_monthly
=========================================================*/
SELECT 
    s.date,
    s.customer_code,
    s.product_code,
    p.product,
    p.variant,
    s.sold_quantity,
    g.gross_price AS gross_price_per_item,
    ROUND(s.sold_quantity * g.gross_price, 2) AS gross_price_total,
    pre.pre_invoice_discount_pct
FROM
    fact_sales_monthly s
        JOIN
    dim_product p ON s.product_code = p.product_code
        JOIN
    fact_gross_price g ON g.fiscal_year = s.fiscal_year
        AND g.product_code = s.product_code
        JOIN
    fact_pre_invoice_deductions AS pre ON pre.customer_code = s.customer_code
        AND pre.fiscal_year = s.fiscal_year
WHERE
    s.fiscal_year = 2021
LIMIT 1500000;

/*=========================================================
Summary

Original Approach:
- Used get_fiscal_year() repeatedly.

Performance Improvement #1:
- Introduced dim_date to eliminate repeated function calls.

Performance Improvement #2:
- Leveraged the fiscal_year column in fact_sales_monthly,
  removing the need for the dim_date join and further
  simplifying the query.

Result:
- Cleaner SQL
- Better readability
- Improved scalability
- Faster execution
=========================================================*/
SELECT 
    s.date,
    s.customer_code,
    s.product_code,
    p.product,
    p.variant,
    s.sold_quantity,
    g.gross_price AS gross_price_per_item,
    ROUND(s.sold_quantity * g.gross_price, 2) AS gross_price_total,
    pre.pre_invoice_discount_pct
FROM
    fact_sales_monthly s
        JOIN
    dim_date dt ON dt.calendar_date = s.date
        JOIN
    dim_product p ON s.product_code = p.product_code
        JOIN
    fact_gross_price g ON g.fiscal_year = dt.fiscal_year
        AND g.product_code = s.product_code
        JOIN
    fact_pre_invoice_deductions AS pre ON pre.customer_code = s.customer_code
        AND pre.fiscal_year = dt.fiscal_year
WHERE
    dt.fiscal_year = 2021
LIMIT 1500000;

-- Performance Improvement # 2
SELECT 
    s.date,
    s.customer_code,
    s.product_code,
    p.product,
    p.variant,
    s.sold_quantity,
    g.gross_price AS gross_price_per_item,
    ROUND(s.sold_quantity * g.gross_price, 2) AS gross_price_total,
    pre.pre_invoice_discount_pct
FROM
    fact_sales_monthly s
        JOIN
    dim_product p ON s.product_code = p.product_code
        JOIN
    fact_gross_price g ON g.fiscal_year = s.fiscal_year
        AND g.product_code = s.product_code
        JOIN
    fact_pre_invoice_deductions AS pre ON pre.customer_code = s.customer_code
        AND pre.fiscal_year = s.fiscal_year
WHERE
    s.fiscal_year = 2021
LIMIT 1500000;

/*=========================================================
Summary

Original Approach:
- Used get_fiscal_year() repeatedly.

Performance Improvement #1:
- Introduced dim_date to eliminate repeated function calls.

Performance Improvement #2:
- Leveraged the fiscal_year column in fact_sales_monthly,
  removing the need for the dim_date join and further
  simplifying the query.

Result:
- Cleaner SQL
- Better readability
- Improved scalability
- Faster execution
=========================================================*/