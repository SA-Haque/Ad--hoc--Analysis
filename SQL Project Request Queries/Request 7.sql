/* 7.Get the complete report of the Gross sales amount for the customer “Atliq
Exclusive” for each month. This analysis helps to get an idea of low and
high-performing months and take strategic decisions.
The final report contains these columns:
Month
Year
Gross sales Amount */

With cte1 AS
	(SELECT s.date, s.fiscal_year,
	    ROUND(SUM(s.sold_quantity*p.gross_price),2) AS Gross_Sales_Amount
FROM fact_sales_monthly s

JOIN dim_customer c
     ON s.customer_code = c.customer_code

JOIN fact_gross_price p 
     ON p.product_code = s.product_code
     
WHERE customer like "%Atliq Exclusive%"
GROUP BY s.date,s.fiscal_year)


SELECT DATE_FORMAT(date,'%M (%Y)')AS Month,fiscal_year, Gross_Sales_Amount
FROM cte1



