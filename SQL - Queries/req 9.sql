CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_markets_in_each_region`(
in_fiscal_year int,
in_top_n int
)
BEGIN
with cte1 as (select c.market, c.region , round(sum(s.gross_price_total)/1000000,2) as gross_sales_mln
from gross_sales s
join dim_customer c
on s.customer_code = c.customer_code
where s.fiscal_year = in_fiscal_year
group by c.market, c.region)
,
cte2 as (select *, dense_rank() over(partition by region order by gross_sales_mln desc) as _rank
from cte1)

select * from cte2 where _rank <= in_top_n ;
END