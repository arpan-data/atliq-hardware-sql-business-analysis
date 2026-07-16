/*=========================================================
Stored Procedure #1 : Top N Markets by Net Sales
=========================================================*/

-- Purpose:
-- Returns the top N markets by net sales
-- for a specified fiscal year.

CREATE PROCEDURE get_top_n_market_by_net_sales(
    IN in_fiscal_year INT,
    IN in_top_n INT
)
BEGIN

    SELECT
        market,
        ROUND(SUM(net_sales) / 1000000, 2) AS total_net_sales_mln
    FROM net_sales AS ns
    WHERE ns.fiscal_year = in_fiscal_year
    GROUP BY market
    ORDER BY total_net_sales_mln DESC
    LIMIT in_top_n;

END;