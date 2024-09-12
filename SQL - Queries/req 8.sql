CREATE DEFINER=`root`@`localhost` PROCEDURE `get_forecast_accuracy`(
in_fiscal_year int
)
BEGIN
with abs_err as (SELECT  customer_code , sum(sold_quantity) as total_sold_quantity, sum(forecast_quantity) as total_forecast_quantity ,
sum((forecast_quantity - sold_quantity)) as net_err,
round(sum((forecast_quantity - sold_quantity))*100/sum(forecast_quantity),2) as net_err_pct,
sum(abs(forecast_quantity - sold_quantity)) as abs_err,
round(sum(abs(forecast_quantity - sold_quantity))*100/sum(forecast_quantity),2) as abs_err_pct
from fact_act_est s 
where s.fiscal_year = in_fiscal_year
group by customer_code)

select a.customer_code, c.customer, c.market, a.total_sold_quantity,
a.total_forecast_quantity, a.net_err, a.net_err_pct, a.abs_err,
a.abs_err_pct,
if(abs_err_pct>100,0,(100 - abs_err_pct)) as forecast_accuracy
from abs_err a 
join dim_customer c
using(customer_code)
order by forecast_accuracy desc ;
END