CREATE DEFINER=`root`@`localhost` PROCEDURE `get_monthly_gross_sale_for-customer`(
in_c_code TEXT
)
BEGIN
select
s.date ,
 round(sum(gp.gross_price * s.sold_quantity),2) as gross_total_price 
from fact_sales_monthly s
join fact_gross_price gp
on s.product_code=gp.product_code and
	get_fiscal_year(s.date)=gp.fiscal_year
where 
find_in_set(s.customer_code , in_c_code)>0
group by s.date;
END
