/* 2. What is the percentage of unique product increase in 2021 vs. 2020? The
final output contains these fields,
unique_products_2020
unique_products_2021
percentage_chg */


With cte1 as 
(SELECT  COUNT(distinct product_code) as unique_products_2020
FROM fact_sales_monthly
	 WHERE fiscal_year = 2020
),
     
cte2 as
(SELECT COUNT(distinct product_code) as unique_products_2021
FROM fact_sales_monthly
	 WHERE fiscal_year = 2021
)
     
SELECT unique_products_2020, unique_products_2021, 
ROUND((unique_products_2021 - unique_products_2020)*100 / unique_products_2020,2) as
percentage_chg
FROM cte1 
CROSS JOIN cte2 ;


     
