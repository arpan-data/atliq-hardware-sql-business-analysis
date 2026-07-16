/*=====================================================================
Project        : AtliQ Hardware SQL Business Analysis

SQL Feature    : SQL Views

Objective:
Create reusable SQL views to simplify complex business queries
and support downstream reporting.

Purpose:
- Simplify complex joins
- Centralize business logic
- Improve query readability
- Enable reusable analytics

SQL Concepts Used:
- CREATE VIEW
- INNER JOIN
- Data Abstraction
- Query Reusability

Author         : Arpan Das
=====================================================================*/
/*=========================================================
View #1 : sales_preinv_discount
=========================================================*/

-- Purpose:
-- Consolidates sales, customer, product, pricing, and
-- pre-invoice discount information into a reusable dataset.
CREATE VIEW sales_preinv_discount AS
    SELECT 
        s.date,
        s.fiscal_year,
        s.customer_code,
        c.market,
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
        dim_customer c ON s.customer_code = c.customer_code
            JOIN
        dim_product p ON s.product_code = p.product_code
            JOIN
        fact_gross_price g ON g.fiscal_year = s.fiscal_year
            AND g.product_code = s.product_code
            JOIN
        fact_pre_invoice_deductions AS pre ON pre.customer_code = s.customer_code
            AND pre.fiscal_year = s.fiscal_year;
     /*=========================================================
View #2 : sales_postinv_discount
=========================================================*/

CREATE VIEW sales_postinv_discount AS
    SELECT 
        s.date,
        s.fiscal_year,
        s.customer_code,
        s.market,
        s.product_code,
        s.product,
        s.variant,
        s.sold_quantity,
        s.gross_price_total,
        s.pre_invoice_discount_pct,
        (s.gross_price_total - s.pre_invoice_discount_pct * s.gross_price_total) AS net_invoice_sales,
        (po.discounts_pct + po.other_deductions_pct) AS post_invoice_discount_pct
    FROM
        sales_preinv_discount s
            JOIN
        fact_post_invoice_deductions po ON po.customer_code = s.customer_code
            AND po.product_code = s.product_code
            AND po.date = s.date;
/*=========================================================
View #3 : net_sales
=========================================================*/

-- Purpose:
-- Creates a reusable net sales dataset for
-- business reporting and dashboard development.

CREATE VIEW net_sales AS 
SELECT 
    *,
    ROUND((net_invoice_sales - net_invoice_sales * post_invoice_discount_pct),
            2) AS net_sales
FROM
    sales_postinv_discount;
    
/*=========================================================
Summary

Views Created:
1. sales_preinv_discount
2. sales_postinv_discount
3. net_sales

Business Benefits:
- Simplified complex joins
- Centralized business logic
- Improved query readability
- Enabled reusable reporting
- Reduced duplicate SQL code

=========================================================*/