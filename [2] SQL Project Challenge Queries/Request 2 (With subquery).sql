/* 2. What is the percentage of unique product increase in 2021 vs. 2020? The
final output contains these fields,
unique_products_2020
unique_products_2021
percentage_chg
*/ 

SELECT X.unique_products_2020, Y.unique_products_2021,
ROUND((Y.unique_products_2021 - X.unique_products_2020)*100 / X.unique_products_2020,2)
       as percentage_chg
FROM(
SELECT count(DISTINCT product_code) AS unique_products_2020
FROM fact_sales_monthly
	 WHERE fiscal_year = 2020) X

CROSS JOIN
     
(SELECT count(DISTINCT product_code) AS unique_products_2021
FROM fact_sales_monthly
	 WHERE fiscal_year = 2021) Y;
     

