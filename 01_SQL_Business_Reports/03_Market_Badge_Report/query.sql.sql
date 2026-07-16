/*=====================================================================
Project         : AtliQ Hardware SQL Business Analysis

Report          : Market Badge Report

Business User   : Sales Manager

Business Requirement:
Determine whether a market qualifies for a Gold or Silver badge
based on total sold quantity for a given fiscal year.

Business Goal:
Classify markets based on sales performance to support
business analysis and strategic decision-making.

Business Metrics:
- Total Sold Quantity
- Market Badge (Gold / Silver)

Required Output:
- Market Badge

SQL Concepts Used:
- Stored Procedure
- Input Parameters
- Output Parameters
- Variables
- Conditional Logic (IF)
- Aggregate Function (SUM)
- INNER JOIN

Author          : Arpan Das
=====================================================================*/

DELIMITER $$

CREATE PROCEDURE get_market_badge(
    IN in_market VARCHAR(45),
    IN in_fiscal_year YEAR,
    OUT out_level VARCHAR(45)
)
BEGIN

    DECLARE qty BIGINT DEFAULT 0;

    -- Default market is India
    IF in_market IS NULL OR in_market = '' THEN
        SET in_market = 'India';
    END IF;

    -- Calculate total sold quantity
    SELECT
        SUM(s.sold_quantity)
    INTO qty
    FROM fact_sales_monthly AS s
    INNER JOIN dim_customer AS c
        ON s.customer_code = c.customer_code
    WHERE
        GET_FISCAL_YEAR(s.date) = in_fiscal_year
        AND c.market = in_market;

    -- Assign Market Badge
    IF qty > 5000000 THEN
        SET out_level = 'Gold';
    ELSE
        SET out_level = 'Silver';
    END IF;

END$$

DELIMITER ;

-- Execute the Stored Procedure

CALL get_market_badge('India', 2021, @market_badge);

SELECT @market_badge AS market_badge;