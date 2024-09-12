CREATE DEFINER=`root`@`localhost` PROCEDURE `get_market_badge`(
in in_market varchar(45),
in in_fiscal_year year,
out out_badge varchar(45)
)
BEGIN

declare qty int default 0;

# set default market as india
if in_market = '' then
set in_market = 'India' ;
end if ;

#to retrieve total quantity for given market and FY
select sum(sold_quantity) into qty
from fact_sales_monthly s
join dim_customer c
on s.customer_code = c.customer_code
where get_fiscal_year(s.date)=in_fiscal_year and
	  c.market = in_market
group by c.market;

# to get market badge (gold or sliver)
if qty > 5000000 then 
set out_badge = 'Gold';
else 
set out_badge = 'Silver' ;
end if;

END