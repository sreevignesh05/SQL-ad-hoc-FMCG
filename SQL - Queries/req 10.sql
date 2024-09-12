CREATE DEFINER=`root`@`localhost` PROCEDURE `get_top_n_products_per_divisions_by_qty_sold`(
in_fiscal_year int,
in_top_n int)
BEGIN
with cte1 as (select p.division, p.product, sum(s.sold_quantity) as total
from fact_sales_monthly s
join dim_product p
on s.product_code = p.product_code
where s.fiscal_year = in_fiscal_year
group by p.product, p.division)
,
cte2 as (select *, dense_rank() over(partition by division order by total desc) as _rank
from cte1)

select * from cte2 where _rank <= in_top_n;
END