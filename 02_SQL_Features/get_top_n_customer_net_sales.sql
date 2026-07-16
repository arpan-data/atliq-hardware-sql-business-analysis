CREATE PROCEDURE `get_top_n_customer_net_sales`(
    IN in_fiscal_year INT,
    IN in_market VARCHAR(45),
    IN in_top_n INT
)
BEGIN

    SELECT
        c.customer,
        ROUND(SUM(s.net_sales) / 1000000, 2) AS total_net_sales_mln
    FROM net_sales AS s
    JOIN dim_customer AS c
        ON c.customer_code = s.customer_code
    WHERE s.fiscal_year = in_fiscal_year
      AND c.market = in_market
    GROUP BY c.customer
    ORDER BY total_net_sales_mln DESC
    LIMIT in_top_n;

END;