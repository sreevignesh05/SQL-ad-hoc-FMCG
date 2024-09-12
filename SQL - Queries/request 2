SELECT 
    s.date,
    SUM(gp.gross_price * s.sold_quantity) AS gross_total_price
FROM
    fact_sales_monthly s
        JOIN
    fact_gross_price gp ON s.product_code = gp.product_code
        AND GET_FISCAL_YEAR(s.date) = gp.fiscal_year
WHERE
    customer_code = '90002002'
GROUP BY s.date
ORDER BY s.date;
