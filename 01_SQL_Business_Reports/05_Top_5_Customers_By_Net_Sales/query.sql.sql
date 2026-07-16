-- 05_Top_Markets_Customers_Products_Report.sql
/*=====================================================================
Project        : AtliQ Hardware SQL Business Analysis

Report         : Top Markets, Customers & Products by Net Sales

Business User  : Sales Manager

Business Requirement:
Identify the top-performing markets, customers, and products
based on net sales for Fiscal Year 2021.

Business Goal:
Analyze sales performance across different business dimensions
to identify major revenue contributors.

Business Metrics:
- Net Sales (Million)

Required Output:
Report 1:
- Market
- Total Net Sales (Million)

Report 2:
- Customer
- Total Net Sales (Million)

Report 3:
- Product
- Total Net Sales (Million)

SQL Concepts Used:
- SQL Views
- INNER JOIN
- Aggregation (SUM)
- GROUP BY
- ORDER BY
- LIMIT

Author         : Arpan Das
=====================================================================*/
/*=========================================================
Report 1 : Top 5 Markets by Net Sales
=========================================================*/

SELECT 
    market,
    ROUND((SUM(net_sales) / 1000000), 2) AS total_net_sales_mln
FROM
    net_sales
WHERE
    fiscal_year = 2021
GROUP BY market
ORDER BY total_net_sales_mln DESC
LIMIT 5;

/*=========================================================
Report 2 : Top 5 Customers by Net Sales
=========================================================*/
SELECT 
    c.customer,
    ROUND((SUM(net_sales) / 1000000), 2) AS total_net_sales_mln
FROM
    net_sales AS s
        JOIN
    dim_customer AS c ON c.customer_code = s.customer_code
WHERE
    fiscal_year = 2021
GROUP BY c.customer
ORDER BY total_net_sales_mln DESC
LIMIT 5;

/*=========================================================
Report 3 : Top 5 Products by Net Sales
=========================================================*/
SELECT 
    product,
    ROUND((SUM(net_sales) / 1000000), 2) AS total_net_sales_mln
FROM
    net_sales
WHERE
    fiscal_year = 2021
GROUP BY product
ORDER BY total_net_sales_mln DESC
LIMIT 5;

/*=========================================================
Summary

Reports Included:
1. Top 5 Markets by Net Sales
2. Top 5 Customers by Net Sales
3. Top 5 Products by Net Sales

Business Benefits:
- Identify high-performing markets
- Recognize top revenue-generating customers
- Analyze best-selling products
- Support strategic sales and marketing decisions

=========================================================*/