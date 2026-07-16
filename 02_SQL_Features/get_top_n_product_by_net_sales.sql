/*=========================================================
Stored Procedure #3 : Top N Products by Net Sales
=========================================================*/

-- Purpose:
-- Returns the top N products by net sales
-- for a specified fiscal year.

CREATE PROCEDURE get_top_n_product_by_net_sales(
    IN in_fiscal_year INT,
    IN in_top_n INT
)
BEGIN

    SELECT
        product,
        ROUND(SUM(net_sales) / 1000000, 2) AS total_net_sales_mln
    FROM net_sales
    WHERE fiscal_year = in_fiscal_year
    GROUP BY product
    ORDER BY total_net_sales_mln DESC
    LIMIT in_top_n;

END;