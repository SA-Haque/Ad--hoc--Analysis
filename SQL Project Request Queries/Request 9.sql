/* 9.Which channel helped to bring more gross sales in the fiscal year 2021
and the percentage of contribution? The final output contains these fields,
channel
gross_sales_mln
percentage*/


With cte1 AS(Select c.channel, 
          ROUND(SUM(g.gross_price * f.sold_quantity)/1000000,2)AS gross_sales_mln
FROM fact_gross_price g

JOIN fact_sales_monthly f
	  ON g.product_code = f.product_code AND
         g.fiscal_year  = f.fiscal_year

JOIN dim_customer c
     ON c.customer_code = f.customer_code
     
WHERE f.fiscal_year = 2021
GROUP BY c.channel)

SELECT channel, CONCAT(gross_sales_mln,' ','M') AS gross_sales_mln,
       CONCAT(ROUND((gross_sales_mln*100 / SUM(gross_sales_mln) OVER()),2), ' ', '%') 
       AS contribution_per

 FROM cte1
 GROUP BY channel
ORDER BY contribution_per DESC;


